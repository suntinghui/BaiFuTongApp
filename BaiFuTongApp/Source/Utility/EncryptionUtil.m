//
//  EncryptionUtil.m
//  POS2iPhone
//
//  Created by  STH on 11/30/12.
//  Copyright (c) 2012 RYX. All rights reserved.
//

#import "EncryptionUtil.h"
#import "CommonCrypto/CommonDigest.h"
#import <openssl/rsa.h>
#import <openssl/x509.h>
#import <openssl/pem.h>
#import <openssl/evp.h>

#define GBKEncoding CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000)

@implementation EncryptionUtil

+ (NSString *) MD5Encrypt:(NSString *) srcStr
{
    const char *cStr = [srcStr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] uppercaseString];
}

+ (NSDictionary *) parsePublickey:(NSString *) publicKey
{
    // 计算key的字节长度并保存到数组
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:[publicKey length]/2];
    for (int i=0; i<[publicKey length]/2; i++) {
        [mutableArray addObject:[publicKey substringWithRange:NSMakeRange(i*2, 2)]];
    }
    
    
    // Byte Length
    int index = 1;
    unsigned int length;    
    NSScanner* pScanner = [NSScanner scannerWithString: [mutableArray objectAtIndex:index]];
    [pScanner scanHexInt: &length];
    if (length > 128) {
        index += length - 128;
    }
    
    // Modulus Length
    index += 2;
    pScanner = [NSScanner scannerWithString: [mutableArray objectAtIndex:index]];
    [pScanner scanHexInt: &length];
    if (length > 128) {
        int i = length - 128;
        NSMutableString *lenStr = [NSMutableString string];
        for (int j=index+1; j<index+i+1; j++) {
            [lenStr appendString:[mutableArray objectAtIndex:j]];
        }
        
        index += i;
        pScanner = [NSScanner scannerWithString: lenStr];
        [pScanner scanHexInt: &length];
    }
    
    // 保存mod值
    NSMutableString *modBuff = [NSMutableString string];
    for (int i=index+1; i<index+1+length; i++) {
        [modBuff appendString:[mutableArray objectAtIndex:i]];
    }
    
    // Exponent Length
    index += length + 2;
    pScanner = [NSScanner scannerWithString: [mutableArray objectAtIndex:index]];
    [pScanner scanHexInt: &length];
    if (length > 128) {
        int i = length - 128;
        NSMutableString *lenStr = [NSMutableString string];
        for (int j=index+1; j<index+i+1; j++) {
            [lenStr appendString:[mutableArray objectAtIndex:j]];
        }
        index += i;
        pScanner = [NSScanner scannerWithString: lenStr];
        [pScanner scanHexInt: &length];
    }
    
    // 保存exponent值
    index += 1;
    NSMutableString *expBuff = [NSMutableString string];
    for (int i=index; i<index+length; i++) {
        [expBuff appendString:[mutableArray objectAtIndex:i]];
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:modBuff forKey:@"mod"];
    [dic setObject:expBuff forKey:@"exp"];
    return dic;
}

+ (NSString *) rsaEncrypt:(NSString *) plainText
{
    // 得到mod 和 exp
    NSString *mod = [UserDefaults objectForKey:PUBLICKEY_MOD]?[UserDefaults objectForKey:PUBLICKEY_MOD]:INIT_PUBLICKEY_MOD;
    NSString *exp = [UserDefaults objectForKey:PUBLICKEY_EXP]?[UserDefaults objectForKey:PUBLICKEY_EXP]:INIT_PUBLICKEY_EXP;
    
    // 将mod 和 exp 转为BIGNUM
    BIGNUM *mod_BN = BN_new();
    BIGNUM *exp_BN = BN_new();
    BN_hex2bn(&mod_BN, [mod cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&exp_BN, [exp cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // Generate RSA
    RSA *rsa = RSA_new();
    
    rsa->e = exp_BN;
    rsa->n = mod_BN;
    
    int flen = RSA_size(rsa);
    unsigned char *encoded = (unsigned char *)malloc(flen);
    bzero(encoded, flen); // 置字节字符串s的前n个字节为零且包括‘\0’

    // NOTICE: RSA_NO_PADDING -- flen -- 必须是 RSA_size(rsa);
    // NOTICE: RSA_PKCS1_PADDING -- flen -- 可以为 strlen([plainText UTF8String])
    int ret = RSA_public_encrypt(
                       flen,
                       (const unsigned char *)[plainText cStringUsingEncoding:NSUTF8StringEncoding],
                       encoded,
                       rsa,
                       RSA_NO_PADDING
                       );
    
    if (ret == -1) { // ERROR
        [NSException raise:@"Encrypt Error" format:@"RSA Encrypt Error: %@ -- rsaEncrypt", [self class]];
        return nil;
    }
    
    
    // 将encoded 转为 NSString
    BIGNUM *temp_BN = BN_new();
    BN_bin2bn((unsigned char *)encoded, flen, temp_BN);
    NSString *encryptStr = [NSString stringWithCString:BN_bn2hex(temp_BN) encoding:NSUTF8StringEncoding];
    
    // How to convert unsigned char to NSString in iOS
    // 下面这种方法也是可以的。
    /***
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for (int i=0; i<ret; i++) {
        [str appendFormat:@"%02x", encoded[i]];
    }
     *****/
    
//    RSA_free(rsa);
//    BN_free(mod_BN);
//    BN_free(exp_BN);
//    BN_free(temp_BN);

    NSLog(@"rsaEncrypt length:%d", [encryptStr length]);
    NSLog(@"rsaEncrypt value: %@", encryptStr);
    return encryptStr;
}


#pragma mark - For Test
/*
 
 I have modulus and exponent. How can I encode/decode data with RSA algotithm on iPhone?
 
 Unfortunately, iOS has no public APIs to deal with raw RSA keys.
 
 There are two things you can do:
 
 1) Instead of giving your app a Public Key, give your app a certificate instead. You can import the certificate with SecCertificateCreateWithData. Then create a trust with SecTrustCreateWithCertificates. Once you have the trust, you can extract the public key with SecTrustCopyPublicKey.
 
 2) The other option is to include OpenSSL in your project. It has all the APIs you need, you can google for example code on how to work with RSA keys. This might be the simpler solution.
 
 I have made available a script to easily build OpenSSL from source. You can grab it from:
 
 http://github.com/st3fan/ios-openssl
 
 */

/*
 http://stackoverflow.com/questions/6665832/iphone-rsa-algorithm-with-modulus-and-exponent
 
 http://stackoverflow.com/questions/4208420/rsa-iphone-public-key
 
 http://blog.csdn.net/miaouu/article/details/6098191  RSASSA-PSS 在 openssl 中的实现
 
 http://www.openssl.org/docs/crypto/RSA_public_encrypt.html   OpenSSL RSA_public_encrypt(3)
 */

/*
 需要注意的是加密的时候，要注意需要加密的内容的长度不能超过RSA密钥的长度，如果你的密钥是1024位的，那么RSA密钥的长度就是128。也就是说每次加密的时候，只能加密小于128个字节长度的内容。
 flen must be less than RSA_size(rsa) - 11 for the PKCS #1 v1.5 based padding modes, less than RSA_size(rsa) - 41 for RSA_PKCS1_OAEP_PADDING and exactly RSA_size(rsa) for RSA_NO_PADDING. The random number generator must be seeded prior to calling RSA_public_encrypt().
 RSA_private_decrypt() decrypts the flen bytes at from using the private key rsa and stores the plaintext in to. to must point to a memory section large enough to hold the decrypted data (which is smaller than RSA_size(rsa)). padding is the padding mode that was used to encrypt the data.
 
 在这里，明文长度也就是密码长度肯定会小于RSA密钥长度！
 */

+ (void) TestRSAEncryAndDecry
{
    NSString *plainText = @"123456";
    
    // Public Key
    NSString *mod = @"b259d2d6e627a768c94be36164c2d9fc79d97aab9253140e5bf17751197731d6f7540d2509e7b9ffee0a70a6e26d56e92d2edd7f85aba85600b69089f35f6bdbf3c298e05842535d9f064e6b0391cb7d306e0a2d20c4dfb4e7b49a9640bdea26c10ad69c3f05007ce2513cee44cfe01998e62b6c3637d3fc0391079b26ee36d5";
    NSString *pubExp = @"11";
    
    // Private Key
    NSString *priExp = @"92e08f83cc9920746989ca5034dcb384a094fb9c5a6288fcc4304424ab8f56388f72652d8fafc65a4b9020896f2cde297080f2a540e7b7ce5af0b3446e1258d1dd7f245cf54124b4c6e17da21b90a0ebd22605e6f45c9f136d7a13eaac1c0f7487de8bd6d924972408ebb58af71e76fd7b012a8d0e165f3ae2e5077a8648e619";
    NSString *p = @"f75e80839b9b9379f1cf1128f321639757dba514642c206bbbd99f9a4846208b3e93fbbe5e0527cc59b1d4b929d9555853004c7c8b30ee6a213c3d1bb7415d03";
    NSString *q = @"b892d9ebdbfc37e397256dd8a5d3123534d1f03726284743ddc6be3a709edb696fc40c7d902ed804c6eee730eee3d5b20bf6bd8d87a296813c87d3b3cc9d7947";
    NSString *dmp1 = @"1d1a2d3ca8e52068b3094d501c9a842fec37f54db16e9a67070a8b3f53cc03d4257ad252a1a640eadd603724d7bf3737914b544ae332eedf4f34436cac25ceb5";
    NSString *dmq1 = @"6c929e4e81672fef49d9c825163fec97c4b7ba7acb26c0824638ac22605d7201c94625770984f78a56e6e25904fe7db407099cad9b14588841b94f5ab498dded";
    NSString *iqmp = @"dae7651ee69ad1d081ec5e7188ae126f6004ff39556bde90e0b870962fa7b926d070686d8244fe5a9aa709a95686a104614834b0ada4b10f53197a5cb4c97339";
    
    
    
    /* -------------------  Encrypto ------------------- */
    // 将mod 和 exp 转为BIGNUM
    BIGNUM *mod_BN = BN_new();
    BIGNUM *exp_BN = BN_new();
    BN_hex2bn(&mod_BN, [mod cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&exp_BN, [pubExp cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // Generate RSA
    RSA *rsa = RSA_new();
    rsa->e      = exp_BN;
    rsa->n      = mod_BN;
    
    int flen = RSA_size(rsa);
    unsigned char *encoded = (unsigned char *)malloc(flen);
    //memset(encoded, 0, flen);
    bzero(encoded, flen);
    
    NSLog(@"%d", flen);
    
    // NOTICE: RSA_NO_PADDING -- flen -- 必须是 RSA_size(rsa);
    // NOTICE: RSA_PKCS1_PADDING -- flen -- 可以为 strlen([plainText UTF8String])
    // if -- RSA_PKCS1_PADDING
    /*
     int ret = RSA_public_encrypt(
     [plainText length],
     (const unsigned char *)[plainText cStringUsingEncoding:NSUTF8StringEncoding],
     encoded,
     rsa,
     RSA_PKCS1_PADDING
     );
     */
    
    int ret = RSA_public_encrypt(
                                 //flen,
                                 strlen([plainText UTF8String]),
                                 (const unsigned char *)[plainText cStringUsingEncoding:NSUTF8StringEncoding],
                                 encoded,
                                 rsa,
                                 RSA_PKCS1_PADDING
                                 );
    
    
    
    if (ret == -1) { // ERROR
        [NSException raise:@"Encrypt Error" format:@"RSA Encrypt Error: %@ -- rsaEncrypt", [self class]];
        return;
    }
    
    BIGNUM *temp = BN_new();
    BN_bin2bn((unsigned char *)encoded, strlen((char *)encoded), temp);
    char *tempEncry = BN_bn2hex(temp);
    NSString *encryptStr = [NSString stringWithCString:tempEncry encoding:NSUTF8StringEncoding];
    NSLog(@"RSA Encrypt:%@", encryptStr);
    
    /* -------------------  Decrypto ------------------- */
    // 将mod 和 exp 转为BIGNUM
    BIGNUM *pub_mod_BN = BN_new();
    BIGNUM *pub_exp_BN = BN_new();
    BIGNUM *pri_exp_BN = BN_new();
    BIGNUM *pri_p_BN = BN_new();
    BIGNUM *pri_q_BN = BN_new();
    BIGNUM *pri_dmp1_BN = BN_new();
    BIGNUM *pri_dmq1_BN = BN_new();
    BIGNUM *pri_iqmp_BN = BN_new();
    
    BN_hex2bn(&pub_mod_BN, [mod cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pub_exp_BN, [pubExp cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_exp_BN, [priExp cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_p_BN, [p cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_q_BN, [q cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_dmp1_BN, [dmp1 cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_dmq1_BN, [dmq1 cStringUsingEncoding:NSUTF8StringEncoding]);
    BN_hex2bn(&pri_iqmp_BN, [iqmp cStringUsingEncoding:NSUTF8StringEncoding]);
    
    // Generate RSA
    RSA *pri_rsa = RSA_new();
    pri_rsa->e      = pub_exp_BN;
    pri_rsa->n      = pub_mod_BN;
    pri_rsa->d      = pri_exp_BN;
    pri_rsa->p      = pri_p_BN;
    pri_rsa->q      = pri_q_BN;
    pri_rsa->dmp1   = pri_dmp1_BN;
    pri_rsa->dmq1   = pri_dmq1_BN;
    pri_rsa->iqmp   = pri_iqmp_BN;
    
    int pri_flen = RSA_size(pri_rsa);
    char *decoded = (char *)malloc(pri_flen);
    bzero(decoded, pri_flen);
    
    int pri_ret = RSA_private_decrypt(
                                      pri_flen, // 无论是RSA_PKCS1_PADDING 还是 RSA_NO_PADDING 此值不变
                                      (const unsigned char *)encoded,
                                      (unsigned char *)decoded,
                                      pri_rsa,
                                      RSA_PKCS1_PADDING);
    
    
    if (pri_ret == -1){
        //[NSException raise:@"Decrypt Error" format:@"RSA Decrypt Error: %@ -- rsaDecrypt", [self class]];
        NSLog(@"---:%d", pri_ret);
        return;
    }
    
//    BIGNUM *pri_temp = BN_new();
//    BN_bin2bn((unsigned char *)decoded, strlen(decoded), pri_temp);
//    char *pri_tempDecry = BN_bn2hex(pri_temp);
//    NSString *DecryptStr = [NSString stringWithCString:pri_tempDecry encoding:NSASCIIStringEncoding];
//    NSLog(@"RSA Decrypt:%@", DecryptStr);
    
    NSLog(@"%s", decoded);

    
    RSA_free(rsa);
    RSA_free(pri_rsa);
    
//    BN_free(mod_BN);
//    BN_free(exp_BN);
    //BN_free(pub_mod_BN);
//    BN_free(pub_exp_BN);
//    BN_free(pri_exp_BN);
//    BN_free(pri_p_BN);
//    BN_free(pri_q_BN);
//    BN_free(pri_dmp1_BN);
//    BN_free(pri_dmq1_BN);
//    BN_free(pri_iqmp_BN);    
}


/********************************************************/

// 以下两个方法是要在证书中取出公钥
+ (NSString *) rsaEncrypt2:(NSString *) plainText
{
    RSA *rsa = ReadPublicKey();
    RSA *pubkeyRsa = RSAPublicKey_dup(rsa);
    
    int flen = RSA_size(rsa);
    unsigned char *encoded = (unsigned char *)malloc(flen);
    bzero(encoded, flen); // 置字节字符串s的前n个字节为零且包括‘\0’
    
    // NOTICE: RSA_NO_PADDING -- flen -- 必须是 RSA_size(rsa);
    // NOTICE: RSA_PKCS1_PADDING -- flen -- 可以为 strlen([plainText UTF8String])
    int ret = RSA_public_encrypt(
                                 strlen([plainText UTF8String]),
                                 (const unsigned char *)[plainText cStringUsingEncoding:NSUTF8StringEncoding],
                                 encoded,
                                 pubkeyRsa,
                                 RSA_PKCS1_PADDING
                                 );
    
    if (ret == -1) { // ERROR
        [NSException raise:@"Encrypt Error" format:@"RSA Encrypt Error: %@ -- rsaEncrypt", [self class]];
        return @"";
    }
    
    BIGNUM *temp_BN = BN_new();
    BN_bin2bn((unsigned char *)encoded, flen, temp_BN);
    NSString *encryptStr = [NSString stringWithCString:BN_bn2hex(temp_BN) encoding:NSUTF8StringEncoding];
    BN_free(temp_BN);
    
    RSA_free(rsa);
    RSA_free(pubkeyRsa);
    
    NSLog(@"rsa -- %d", [encryptStr length]);
    NSLog(@"rsa -- %@", encryptStr);
    
    return encryptStr;
}

RSA* ReadPublicKey()
{
    NSString * path = [[NSBundle mainBundle] pathForResource:@"ruralBank" ofType: @"cer"];
    FILE *fp = fopen ([path cStringUsingEncoding:NSUTF8StringEncoding], "r");
    
    //此处出错　没有new
    //    X509 *x509;
    X509 *x509= X509_new ();
    
    int len;
    unsigned char buf[50000],*p;
    EVP_PKEY *pkey;
    RSA *rsa;
    
    if (NULL == fp)
    {
        return NULL;
    }
    
    len=fread(buf,1,50000,fp);
    
    p=buf;
    
    d2i_X509(&x509,(const unsigned char **)&p,len);
    
    fclose(fp);
    
    if (NULL == x509)
    {
        return NULL;
    }
    
    pkey = X509_extract_key(x509);
    rsa = EVP_PKEY_get1_RSA(pkey);
    
    X509_free(x509);
    EVP_PKEY_free(pkey);
    
    return rsa;
}


@end
