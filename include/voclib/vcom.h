//
//  vcom.h
//  vcom
//
//  Created by Alex on 5/9/13.
//  Copyright (c) 2013年 www.itron.com.cn All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVAudioSession.h>
#import <MediaPlayer/MediaPlayer.h>
#import "CSwiperStateChangedListener.h"

#define YLOG

#define  VCOM_VER  101
//命令和子命令的位置
#define CMD_POS 4
#define SUBCMD_POS 5
#define CMD_RES_POS 6
//通讯模式定义
#define  VCOM_TYPE_F2F 0
#define  VCOM_TYPE_FSK 1
//控制标志定义
#define CTRL_FLAG_REPORT_TRACK_ORG_LENGTH 0x8
#define CTRL_FLAG_REPORT_MASK_CARD_NUM    0xC
#define CTRL_FLAG_REPORT_MAC              0xE
#define CTRL_FLAG_RANDOM_NUM_TWO_SIDES    0xF

#define NOTIFY_CHECKMIC @"NOTIFY_CHECKMIC"
#define NOTIFY_RECORDDATA @"NOTIFY_RECORDDATA"

extern bool recflag;
extern char ppdata[20][800];
extern int  ppDataPos;

@interface vcom:NSObject
{
    short* mbuf;
    int mbuflen;
    //返回数据指针和长度
    char* retdata;
    int retdatalen;
    id<CSwiperStateChangedListener> eventListener;
}
@property(retain,nonatomic) NSTimer *itTimer;
@property(nonatomic) char* retdata;
@property(nonatomic) int retdatalen;
@property(nonatomic,retain) id<CSwiperStateChangedListener> eventListener;

//得到音频对象的全局变量
+(vcom*)getInstance;
//打开音频收发数据功能
-(void)open;
//关闭音频收发数据功能
-(void)close;
//初始化,一般在viewDidLoad函数中创建对象后调用一次，
- (id)init;

//工具函数,返回bin二进制数据，长度为binlen的十六进制字符串
-(NSString*) HexValue:(char*)bin Len:(int)binlen;
//工具函数，打印二进制缓冲区内容
-(void)HexPrint:(char*)data Len:(int)_len;

//放音音量控制,该函数暂时没有用处，100最大，0最小
-(void)setVloumn:(NSInteger )vol;

//启动录音，启动数据接收
-(void) StartRec;

//停止录音，停止数据接收
-(void)StopRec;

//设置通讯模式，发送和接收采用fsk还是f2f，VCOM_TYPE_F2F和VCOM_TYPE_FSK
-(void) setMode:(int)smode recvMode:(int)rmode;

//得到发送的模式，fsk或者f2f
-(int) getSendMode;

//得到接收的模式，fsk或者f2f
-(int) getRecvMode;

//发送指令数据
//cmd-从协议版本字段到数据的十六进制值
//0-ok -1 失败
-(int) playCmd:(char*)cmdstr;


-(void)setMac:(bool) state;
//*****************************************************
//fsk发送指令封装
//播放内存的语音。内部调用。
//获取ksn
-(void) Request_GetKsn;

//扩展获取ksn
-(void) Request_GetExtKsn;

//获取随机数
-(void) Request_GetRandom:(int)randLen;

//获取psam卡上保存的商户号码和终端号
-(void) Request_VT;

//退出
-(void) Request_Exit;

//获取电池电量
-(void) Request_BatLevel;

//获取打印机状态
-(void) Request_PrtState;

//重传指令
-(void) Request_ReTrans;

//获取磁卡卡号明文
-(void) Request_GetCardNo:(int)timeout;

//获取磁道信息明文
-(void) Request_GetTrackPlaintext:(int)timeout;

/*!
 @method
 @abstract 获取磁道密文数据
 @discussion 需要获取磁道密文时候调用
 @param desMode 模式 请填0
 @param _keyIndex PSAM卡秘钥索引
 @param _random 随机数 由PSAM卡决定随机数和随机数长度
 @param _randomLen 随机数长度
 @param _tiem 超时时间
 */
-(void) Request_GetDes:(int)desMode
              keyIndex:(int)_keyIndex
                random:(char*) _random
             randomLen:(int)_randomLen
                  time:(int)_time;

/*!
 @method
 @abstract 获取pin密文数据
 @discussion 传入金额，请求用户输入密码时候调用
 @param desMode 模式 请填0
 @param _keyIndex PSAM卡秘钥索引
 @param _cash 消费金额
 @param _cashLen 消费金额长度 
 @param _random 随机数 由PSAM卡决定随机数和随机数长度
 @param _randomLen 随机数长度
 @param _panData 参与加密计算的数据
 @param _panDataLen 参加加密计算的数据长度 数据域内容定长为8字节的PAN，如果不需要PAN，则直接填8个0x00
 @param _tiem 超时时间
 */
-(void) Request_GetPin:(int)pinMode
              keyIndex:(int)_keyIndex
                  cash:(char*)_cash cashLen:(int)_cashLen
                random:(char*)_random randomLen:(int)_randdomLen
               panData:(char*)_panData pandDataLen:(int)_panDataLen
                  time:(int)_time;

/*!
 @method
 @abstract 获取计算mac的数据
 @discussion 对mac数据进行处理,尾部加0到8的整数，然后每8个字节异或
 @param macMode 模式 请填0 表示如果数据为非8字节对齐，则后补00为8字节对齐，然后点付宝根据自己的版本来处理数据
 @param _keyIndex PSAM卡秘钥索引
 @param _random 随机数 由PSAM卡决定随机数和随机数长度
 @param _randomLen 随机数长度
 @param _data 请求计算mac的数据
 @param _dataLen 数据长度
 */
-(void) Request_GetMac:(int)macMode
              keyIndex:(int)_keyIndex
                random:(char*)_random randomLen:(int)_randomLen
                  data:(char*)_data dataLen:(int)_dataLen;

//请求psam卡mac计算
-(void) Request_CheckMac:(int)macMode
                keyIndex:(int)_keyIndex
                  random:(char*)_random randomLen:(int)_randomLen
                    data:(char*)_data dataLen:(int)_dataLen;
//请求psam卡mac计算
-(void) Request_CheckMac2:(int)macMode
                keyIndex:(int)_keyIndex
                  random:(char*)_random randomLen:(int)_randomLen
                    data:(char*)_data dataLen:(int)_dataLen
                    mac:(char*)_mac maclen:(int)_maclen;
//请求pasm卡mac校验
-(void) Request_CheckMacEx:(int)macMode keyIndex:(int)_keyIndex random:(char *)_random randomLen:(int)_randomLen data:(char *)_data dataLen:(int)_dataLen mac:(char*)_mac maclen:(int)_maclen;

//
/*!
 @method
 @abstract 扩展请求连续操作2  0293
 @discussion 传入金额，请求用户先刷卡然后输入密码
 @param desMode 模式 0=磁卡密文  1=磁卡密文+密码  2=手工输入卡号+磁卡密文+密码
 3=二次输入+磁卡密文+密码
 @param _PINKeyIndex PIN秘钥索引
 @param _DESKeyIndex DES秘钥索引
 @param _MACKeyIndex MAC秘钥索引
 @param _CtrlMode bit0 －1/0 上送的数据有/无mac
 Bit1 － 1/0上送的数据是有/无终端id
 Bit2 － 1/0上送的数据是有/无psam卡号
 Bit3 － 1/0上送的数据是有/无卡号密文数据
 Bit4 － 1/0 密钥索引启用/不启用
 Bit5 － 1/0磁道信息明文/密文
 Bit6 －  保留
 Bit7 － 1/0 手输卡号密文/明文
 @param _ParameterRandom 随机数 由PSAM卡决定随机数和随机数长度
 @param _ParameterRandomLen 随机数长度
 @param _cash 消费金额
 @param _cashLen 消费金额长度
 @param _appendData 参与加密计算的数据
 @param _appendDataLen 参加加密计算的数据长度 数据域内容定长为8字节的PAN，如果不需要PAN，则直接填8个0x00
 @param _tiem 超时时间
 */
-(void) Request_ExtCtrlConOper:(int)mode
                   PINKeyIndex:(int)_PINKeyIndex
                    DESKeyInex:(int)_DESKeyIndex
                   MACKeyIndex:(int)_MACKeyIndex
                      CtrlMode:(char)_CtrlMode
               ParameterRandom:(char*)_ParameterRandom ParameterRandomLen:(int)_ParameterRandomLen
                          cash:(char*)_cash cashLen:(int)_cashLen
                    appendData:(char*)_appendData appendDataLen:(int)_appendDataLen
                          time:(int)_time;

/*!
 @method
 @abstract 请求连续操作 0208
 @discussion 传入金额，请求用户先刷卡然后输入密码
 @param desMode 模式 0=磁卡密文  1=磁卡密文+密码  2=手工输入卡号+磁卡密文+密码
 3=二次输入+磁卡密文+密码
 @param _ParameterRandom 随机数 由PSAM卡决定随机数和随机数长度
 @param _ParameterRandomLen 随机数长度
 @param _cash 消费金额
 @param _cashLen 消费金额长度
 @param _appendData 参与加密计算的数据
 @param _appendDataLen 参加加密计算的数据长度 数据域内容定长为8字节的PAN，如果不需要PAN，则直接填8个0x00
 @param _tiem 超时时间
 */
-(void) Request_ConOper:(int)mode
        ParameterRandom:(char*)_ParameterRandom ParameterRandomLen:(int)_ParameterRandomLen
                   cash:(char*)_cash cashLen:(int)_cashLen
             appendData:(char*)_appendData appendDataLen:(int)_appendDataLen
                   time:(int)_time;


/*!
 @method
 @abstract 扩展请求连续操作 0288
 @discussion 传入金额，请求用户先刷卡然后输入密码
 @param desMode 模式 0=磁卡密文  1=磁卡密文+密码  2=手工输入卡号+磁卡密文+密码
 3=二次输入+磁卡密文+密码
 @param _ParameterRandom 随机数 由PSAM卡决定随机数和随机数长度
 @param _ParameterRandomLen 随机数长度
 @param _cash 消费金额
 @param _cashLen 消费金额长度
 @param _appendData 参与加密计算的数据
 @param _appendDataLen 参加加密计算的数据长度 数据域内容定长为8字节的PAN，如果不需要PAN，则直接填8个0x00
 @param _tiem 超时时间
 */
-(void) Request_ExtConOper:(int)mode
           ParameterRandom:(char*)_ParameterRandom ParameterRandomLen:(int)_ParameterRandomLen
                      cash:(char*)_cash cashLen:(int)_cashLen
                appendData:(char*)_appendData appendDataLen:(int)_appendDataLen
                      time:(int)_time;

/*!
 @method
 @abstract 更新工作密钥 0210
 @discussion 更新工作秘钥
 @param Mainkey 主秘钥索引
 @param _PinKey 更新Pin秘钥
 @param _PinKeyLen 更新的Pin秘钥长度
 @param _MacKey 更新的Mac秘钥
 @param _MacKeyLen 更新的Mac秘钥长度
 @param _DesKey 更新的Des秘钥
 @param _DesKeyLen 更新的Des秘钥长度
 */
-(void) Request_ReNewKey:(int)Mainkey PinKey:(char*)_PinKey PinKeyLen:(int)_PinKeyLen
                  MacKey:(char*)_MacKey MacKeyLen:(int)_MacKeyLen
                  DesKey:(char*)_DesKey DesKeyLen:(int)_DesKeyLen;


/*!
 @method
 @abstract 更新终端号码和商户号 0211
 @discussion 更新工作秘钥
 @param vendor 商户号数据
 @param _vendorLen 商户号长度
 @param _terid 终端号数据
 @param _teridLen 终端号长度
 */
-(void) Request_ReNewVT:(char*)vendor vendorLen:(int)_vendorLen
                  terid:(char*)_terid teridLen:(int)_teridLen;

//热敏打印数据
//data-打印内容 cnt-打印数量
/*
 格式:
 类型,内容
 返回值:0-组包成功 -1-组包失败
 */
//-(int) rmPrint:(char[40][200]) _data dataLen:(int) len printCnt:(int)cnt;
-(int) rmPrint2:(NSMutableArray*) lineList pCnt:(int)_cnt;
-(int) rmPrint3:(NSMutableArray*) lineList pCnt:(int)_cnt pakLen:(int)_paklen;

//打印数据
-(void) Request_PrtData:(int)currentPackage
           totalPackage:(int)_totalPackage
                  count:(int)_count
                   data:(char*)_data dataLen:(int)_dataLen;


// 请求psam卡DES加密 (04H)
-(void) Request_DataEnc:(int)keyIndex
                TimeOut:(int)_itmeOut
                   Mode:(int)_mode
        ParameterRandom:(char*)_ParameterRandom
     ParameterRandomLen:(int)_ParameterRandomLen
                   data:(char*)_data
                dataLen:(int)_dataLen;
/*
 请求用户输入
 输入参数:
 Ctrlmode: 控制模式
 bit0－bit4表示模式：
 0：表示银行卡卡号输入，
 1：表示数字类输入
 2：表示支持字母数字输入
 Bit5 =0/1 无二次输入/有二次输入
 Bit6=0/1 密钥索引是否启用
 Bit7 =0/1 数据是否加密
 
 _tout: 超时时间(秒）
 minvalue:允许输入的最小长度
 maxvalue:允许输入的最大长度
 kindex: 加密时使用的密钥索引
 _random: 参与加密的随机数
 _title: 用户输入时显示的提示信息
 */
-(void)Get_Userinput:(int)ctrlmode
             timeout:(unsigned char)_tout
                 min:(unsigned char)minvalue
                 max:(unsigned char)maxvalue
            keyindex:(unsigned char)kindex
              random:(char*)_random randomLen:(int)_randdomLen
               title:(char*)_title titleLen:(int)_titleLen;
//显示信息
//info信息内容
//timer-显示时间（秒）
-(void) display:(NSString*) strinfo  timer:(int)_time;

//返回结果报文解析函数
//返回 -1-报文错误 0-报文格式正确 其他，错误的结果
-(int)ParseResult:(unsigned char*)buf bufLen:(int)_bufLen res:(vcom_Result*)_res;


//解析加密后的Pin密文数据
//参数
//输入
//buf:返回数据缓冲
//_bufLen:返回数据缓冲长度
//输出
//_pin:加密的pin缓冲
//返回值:
//_pin缓冲长度
-(int) GetEnPinData:(char*) buf bufLen:(int)_bufLen pin:(char*)_pin;

/*
 解析返回结果的2，3磁道数据
 输入数据:
 buf,_bufLen:返回数据指针和长度
 输出数据:
 _cdbuf,_cdbufLen：2，3磁道加密数据和长度
 _pan:输出的pan数据
 */
/*
 -(void)getEn23CiDao:(char*) buf bufLen:(int)_bufLen
 cdbuf:(char*)_cdbuf cdbufLen:(int*)_cdbufLen
 pan:(char*)_pan
 rand:(char*)_rand randLen:(int*)_randLen;
 */

/*
 解析获取扩展卡号取的返回数据
 psamno8bytes:8字节psam卡号码
 hardno10bytes:10字节的硬件序列号
 */

 -(void)GetExtKsnRetData:(char*) psamno8bytes
 hardNo:(char*)hardno10bytes;

-(char *)GetKsnRetData;
 
//*****************************************************
//私有函数
//播放内存的语音。内部调用。
-(void) playVocBuf:(short*)buf Len:(int)buflen;

//是否耳机插入,返回1-耳机插入 0-耳机未插入，内部调用函数
- (int)hasHeadset;

/*
 f2f指令封装
 */
//读取ksn号码
-(void)f2f_getksn;

//密文刷卡指令
//ctrlFlag-控制标志
//rand randLen-随机数和随机数长度
//fjLen fjData-附件数据长度和附加数据
-(void)f2f_getMiWenCiKa:(char) ctrlFlag tiemout:(char)tout  randLen:(int)_randLen rand:(char*)_rand
                  fjLen:(int) _fjLen fjData:(char*)_fjData;

char* HexToBin(char* hex);

char* BinToHex(char* bin,int off,int len);

@end


