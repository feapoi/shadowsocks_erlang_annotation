shadowsocks-erlang代码注解
=====  
shadowsocks原理简介
-----
**shadowsocks服务端提供tcp、udp协议（未实现）转发代理的功能，
例如机器A访问某网站收到限制，机器A把请求通过加密发给不受限制的机器B由B代为访问，访问的结果再加密发回机器A，从而达到突破限制的作用。**
    
协议
-----
- 客户端和shadowsocks服务端之间使用sock5协议通信，在转发之前需要进行一次握手，来验证客户端的信息，握手成功后即可进行转发
- sock5是基于TCP的会话层协议，即使是UDP转发，也是使用TCP来握手，发送请求

结构
-----
- 首先启动最上层监控树sserl_sup
- sserl_sup之下有sserl_manager,sserl_listener_sup,以及两个event
- 主要功能由sserl_listener_sup下的进程来实现，sserl_listener_sup下启动sserl_listener，用来监听客户端发来的握手请求，当握手成功后，
sserl_listener下会启动一个sserl_con进程，获取socket的控制权，由sserl_con进程来为用户进行转发服务

加密
-----
**该项目支持rc4_md5, aes_128_cfb, aes_192_cfb, aes_256_cfb 4种加密方式，加密的目的是打乱请求，突破访问限制，所以无需过多考虑加密方法的安全性**
- rc4_md5属于流加密，先要初始化流加密状态，
先用秘钥进行md5加密,crypto:hash(md5, Date)
    ，结果再用rc4加密，crypto:stream_init(rc4, Date)
    得到流加密状态
- aes属于块加密，直接用key(秘钥)，IV（向量）来进行加密,crypto:block_decrypt(aes_cfb128, Date)