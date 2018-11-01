use master
go

create database [Library] 
ON PRIMARY
(NAME=Library,FILENAME='D:\database\mydata.mdf',SIZE=3MB,MAXSIZE=6MB,FILEGROWTH=2MB)
LOG ON
(NAME=Library_log,FILENAME='D:\database\mydata_log.ldf',SIZE=1MB,MAXSIZE=2MB,FILEGROWTH=1MB)
go

use Library
go

--表1图书分类表Category
create table Category 
(
  Id int identity(1,1) primary key,
  Code NVarchar(50) not null,
  Name NVarchar(250) not null,
  [Description] NVarchar(1000),
)
go

--表2图书表Book
create table Book 
(
    Id int identity(1,1) primary key,
    Code NVarchar(50) not null,
    Name NVarchar(100) not null,
    Authors NVarchar(100) not null,
    Press NVarchar(100) ,   --出版社
    ImageUrl NVarchar(1000),
    [Description] NVarchar(2000),
    PublishDate DateTime,   --出版日期
    Price Decimal (18,2),
    [Status] NVarchar(100),   --状态: 未在库,在库,外借.
    Category_ID Int not null foreign key references Category(Id),
)
go 

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21001','浮生六记','沈复',' 辽宁大学出版社','/PImages/wx_fslj.jpg','我们要学会用美的眼光，去发现周遭的一切”著名主持人汪涵念念不忘反复在节目中向观众推荐的一本书！本版白话精心译述，民国本精',2015-08-01,21.00,'在库',1)



--表3读者表Reader
create table Reader 
(
    Id int identity(1,1) primary key,
    Code NVarchar(50) not null,
    Name NVarchar (50) not null,
    Class NVarchar(50) null,
    Email NVarchar(100) not null,   
    [Password] NVarchar(100) not null, 
    Price Decimal (18,2) not null, 
)
go

--表4借阅表Borrow
create table Borrow 
(
    Id int identity(1,1) primary key,
    Reader_ID Int not null foreign key references Reader(Id),
    Book_ID Int not null foreign key references Book(Id),
    BorrowDate DateTime not null,         --借
    ShouldDate DateTime not null,         --应还
    ReturnDate DateTime not null,         --实还
    Renew NVarchar(100) not null check(Renew in('是','否')), 
)
go

--表5罚款缴纳表Fine
create table Fine 
(
    Id int identity(1,1) primary key,
    Borrow_ID Int not null foreign key references Borrow(Id),
    Reader_ID Int not null foreign key references Reader(Id), 
    OverDays Int not null,    --超期
    Payment Decimal (18,2) not null, 
)
go

insert into Category(Code,Name) 
values('10001','文学')
insert into Category(Code,Name) 
values('10002','励志')
insert into Category(Code,Name) 
values('10003','小说')
insert into Category(Code,Name) 
values('10004','少儿')
insert into Category(Code,Name) 
values('10005','历史')
insert into Category(Code,Name) 
values('10006','技术')
insert into Category(Code,Name) 
values('10007','期刊')




insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21002','平凡的世界（全三册）','路遥','北京十月文艺出版社','/PImages/wx_pfdsj.jpg',
'这是一部现实主义小说，也是小说化的家族史。作家高度浓缩了中国西北农村的历史变迁过程，作品达到了思想性与艺术性的高度统一，特别是主人公面对困境艰苦奋斗的精神，对今天的大学生朋友仍有启迪。',
'2013-12-1',45.00,'在库',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21003','假如给我3天光明','凯勒','北方文艺出版社','/PImages/wx_jrgw3tgm.jpg',
'假如给我3天光明(全译本) 原著 无删减 海伦凯勒著 世界文学名著 青少年版学生版世界名著 初高中生课外书籍',
'2013-01-11',18.00,'在库',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21004','鲁滨逊漂流记','(英)丹尼尔·笛福|译者:朱佳怡','陕西师范大学出版社','/PImages/wx_lbxplj.jpg',
'震撼欧洲文学史的惊世作品，倾注了梦想与勇气的冒险之旅，充满理想与拼搏精神的孤胆勇士。',
'2012-11-11',15.50,'在库',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21005','朝花夕拾','鲁迅','中国文联出版社','/PImages/wx_zhxs.jpg',
'朝花夕拾 鲁迅作品 含朝花夕拾、野草及生平年表 鲁迅散文集 鲁迅散文诗集 教育部新课标推荐数目 中国现当代文学名著',
'2016-03-11',14.50,'在库',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21006','围城',' 钱钟书','人民文学出版社','/PImages/wx_wc.jpg',
'钱锺书所著的《围城》是一幅栩栩如生的世井百态图，人生的酸甜苦辣千般滋味均在其中得到了淋漓尽致的体现。',
'1991-02-11',23.80,'在库',1)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22001','羊皮卷全集','曼狄诺编','中国妇女出版社','/PImages/lz_jrgw3tgm.jpg',
'成功圣经，每一个积极向上的人都应该要读的书，它揭示了希望、财富、成功...',
'2015-01-01',25.20,'在库',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22002','人性的弱点',' 戴尔·卡耐基著','浙江文艺出版社','/PImages/lz_rxdld.jpg',
'帮你迅速提升情商和谈话技巧的经典！全新畅销译本，未作任何增删！完整囊括人际关系的... ',
'2017-01-1',31.80,'在库',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22003','厚黑学正版全集','李宗吾',' 九州出版社','/PImages/lz_hhxqj.jpg',
'厚黑学正版全集 李宗吾原著成功学说话办事经商职场管理厚黑学全集 鬼谷子塔木德正能量人际关系小说创业书籍励志成功书籍',
'2009-01-11',35.20,'在库',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22004','钢铁是怎样炼成的','列夫托尔斯泰著','中国文联出版社','/PImages/lz_gtszylcd.jpg',
'世界经典文学名著小说畅销书籍',
'2012-11-11',16.80,'在库',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22005','将来的你','黎芫','天津人民出版社','/PImages/lz_jldn.jpg',
'将来的你一定会感谢现在拼命的自己 青少年成功正能量青春励志文学小说心灵鸡汤人生哲学女性汤木畅销书籍',
'2017-03-01',29.80,'在库',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22006','摆渡人','[英]克莱儿·麦克福尔','百花洲文艺出版社','/PImages/lz_bdr.jpg',
'如果命运是一条孤独的河流，谁会是你灵魂的摆渡人？',
'2015-06-01',25.80,'在库',2)



insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23001','从你的全世界路过',' 张嘉佳',' 湖南文艺出版社','/PImages/xs_cndqsjlg.jpg',
'让所有人心动的故事...',
'2013-11-01',23.80,'在库',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23002','活着','余华','作家出版社','/PImages/xs_hz.jpg',
'《活着》讲述了农村人福贵悲惨的人生遭遇。福贵本是个阔少爷，可他嗜赌如命，终于赌光了家业，一贫如洗... ',
'2012-08-1',31.80,'在库',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23003','了不起的盖茨比','菲茨杰拉德','北方文艺出版社','/PImages/xs_lbqdgcb.jpg',
'小说通过完美的艺术形式，描写了20年代贩酒暴 发户盖茨比所追求的“美国梦”的幻灭，揭示了美国社会的悲剧。',
'2012-01-11',35.20,'在库',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23004','解忧杂货店','东野圭吾','作者出版社','/PImages/xs_jyzhd.jpg',
'他们将困惑写成信投进杂货店，奇妙的事情随即不断发生。生命中的一次偶然交会，将如何演绎出截然不同的人生？',
'2014-05-01',37.80,'在库',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23005','人生','路遥','北京十月文艺出版社','/PImages/xs_rs.jpg',
'改革时期陕北高原的城乡生活为时空背景，叙述了高中毕业生高加林回到土地又离开土地，再回到土地这样人生的变化过程。',
'2012-03-01',17.00,'在库',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23006','假面前夜','东野圭吾','作者出版社','/PImages/xs_jmqy.jpg',
'是保护假面，还是揭开假面，尚是职场新人的酒店前台山岸尚美和年轻的刑警新田浩介会如何应对？4个发人深省的故事将给出答案。',
'2016-02-29',30.50,'在库',3)



insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24001','蚯蚓的日记','(美)朵琳·克罗宁著','明天出版社','/PImages/sr_qydrj.jpg',
'蚯蚓的日记绘本信谊绘本蚯蚓日记儿童绘本0-3-4-6周岁幼儿书籍图书幼儿园图画书宝宝启蒙故事书',
'2013-04-01',16.80,'在库',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24002','格林童话','[德]雅各布·格林','外语教学与研究出版社','/PImages/sr_glth.jpg',
'这些童话故事语言质朴，情节明快，含义深刻。孩子们在阅读这些童话的时候，就像在聆听老奶奶讲故事一样，能从中感受到19世纪人们的精神世界。',
'2012-01-1',11.80,'在库',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24003','童谣三百首','匿名','安徽少年儿童出版社','/PImages/sr_ty300s.jpg',
'童谣文字简单、富含韵律、易学易记、朗朗上口，是非常符合儿童阅读特点和审美心理的文学形式。',
'2015-02-01',17.80,'在库',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24004','安徒生童话','安徒生','新世纪出版社','/PImages/sr_atsth.jpg',
'为孩子营造属于他们的童话世界 ',
'2014-09-01',18.80,'在库',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24005','一千零一夜','佚名','新世纪出版社','/PImages/sr_1001y.jpg',
'为孩子营造属于他们的童话世界 ',
'2014-09-01',18.80,'在库',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24006','伊索寓言','伊索','新世纪出版社','/PImages/sr_ysyy.jpg',
'为孩子营造属于他们的童话世界 ',
'2014-09-01',18.80,'在库',4)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25001','第二次世界大战全史','白虹','中国华侨出版社','/PImages/ls_2z.jpg',
'回顾战争，重温那段血与火的历史，不仅可以丰富历史知识，还能够以史为鉴，吸取教训，继而深入探讨战争与和平这一人类历史的永恒主题。',
'2016-01-01',21.50,'在库',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25002','中国通史','梦华','中国华侨出版社','/PImages/ls_zgts.jpg',
'这是一本讲述中国历史的读物，全面反映了从传说时代到清朝灭亡的历史全景，同时书中还设置了中国大事记、世界大事记等多个知识板块。',
'2016-01-1',21.50,'在库',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25003','资治通鉴','司马光','北方妇女儿童出版社','/PImages/ls_zztj.jpg',
'《资治通鉴》是我国古代著名历史学家、政治家司马光和他的助手历时十九年编纂的一部规模空前的编年体通史巨著。',
'2015-01-01',14.80,'在库',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25004','这个历史挺靠谱','袁腾飞','湖南人民出版社','/PImages/ls_zglstkp.jpg',
'《历史是个什么玩意儿》系列的升级珍藏版。本系列开启全民读史新潮流，自问世以来畅销至今',
'2013-07-01',62.70,'在库',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25005','史记','司马迁','中国华侨出版社','/PImages/ls_sj.jpg',
'精选了其中*具代表性且*精彩的篇章辑录成书，并绘制了大量精美插图，力求更加真实、直观、全面地将中国历史的丰富与精彩呈现在读者面前',
'2014-10-01',29.80,'在库',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25006','一本书读完历代趣闻轶事','张平','北京联合出版公司','/PImages/ls_ybs.jpg',
'以知识性和趣味性为宗旨，全方位、多角度地展示了先秦到民国时期*有研究价值和*为人们所关注的趣闻轶事',
'2014-11-01',26.80,'在库',5)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26001','机器学习项目开发实践',' [美]Mathias Brandewinder(马蒂亚斯·布兰德温德尔)','人民邮电出版社','/PImages/js_jqxx.jpg',
'对本书的阅读，读者无须接触枯燥的数学知识，便可快速上手，为日后的开发工作打下坚实的基础',
'2016-01-01',21.50,'在库',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26002','深度学习-方法及应用','谢磊','技术出版社','/PImages/js_sdxx.jpg',
'这本书对深度学习方法以及它在各种信号与信息处理任务中的应用进行了概述',
'2016-04-1',31.80,'在库',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26003','编程珠玑','[美]乔恩·本特利','人民邮电出版社','/PImages/js_bczj.jpg',
'本书的特色是通过一些精心设计的有趣而又颇具指导意义的程序，对实用程序设计技巧及基本设计原则进行了透彻而睿智的描述。',
'2015-01-01',37.40,'在库',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26004','Java从入门到精通','明日科技','清华大学出版社','/PImages/js_java.jpg',
'从初学者角度出发，通过通俗易懂的语言、丰富多彩的实例，详细介绍了使用Java语言进行程序开发需要掌握的知识。',
'2012-09-01',52.60,'在库',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26005','从应用到创新','陈皓','电子工业出版社','/PImages/js_cyydcx.jpg',
'手机硬件研发与设计 本书是由一线工程师撰写的详细阐述手机硬件研发与设计的专业图书',
'2016-10-01',78.20,'在库',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26006','从0到1',' 彼得蒂尔|布莱克马斯特斯','中信出版社','/PImages/js_c0d1.jpg',
'开启商业与未来的秘密 一位传奇的创投教父，一部开启秘密的商业之作，一部事关所有人的生存哲学 ',
'2015-01-29',27.00,'在库',6)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27001','读懂互联网+','马云|曾鸣|高红冰','中信出版社','/PImages/qk_ddhlw.jpg',
'由马云、曾鸣、高红冰、金建杭、周其仁等著,集合了国内**的企业家、学者 从其自身长期从事的行业、研究出发，结合实践经验 和理论研究，描绘出清晰而全面的经济发展趋势。一 本书读懂“互联网+”。',
'2015-07-01',35.50,'在库',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27002','枪炮、病菌与钢铁','戴蒙德','上海译文出版社','/PImages/qk_qbg.jpg',
'在这部开创性的著作中，演化生物学家、人类学家贾雷德戴蒙德揭示了事实上有助于形成历史最广泛模式的环境因素，从而以震撼人心的力量摧毁了以种族主义为基础的人类史理论。',
'2016-07-1',31.80,'在库',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27003','影响力',' (美)罗伯特','北京联合出版公司','/PImages/qk_yxl.jpg',
'隐藏在冲动地顺从他人行为背后的6大心理秘笈，正是这一切的根源。那些劝说高手们，总是熟练地运用它们，让我们就范。',
'2016-09-01',49.00,'在库',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27004','阿米巴经营','(日)森田直行','机械工业出版社','/PImages/qk_ambjy.jpg',
'介绍了阿米巴经营的实战方法和案例，帮助企业将人的潜力无限地激发出来。',
'2015-07-01',23.00,'在库',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27005','岁月静好,不忘初心','林清玄','北京联合出版公司','/PImages/qk_syjh.jpg',
'本书是著名作家林清玄的一本哲理散文集。单纯的文字，高远的思想，字里行间中充满着人生感悟。作者借日常生活中平淡无奇的小事向读者展示出平等无私的大智慧。',
'2016-12-01',27.20,'在库',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27006','销售就是要玩转情商','科林斯坦利','武汉出版社','/PImages/qk_xsjs99.jpg',
'99%的人都不知道的销售软技巧,本书从情商出发，将销售行业中常见的销售渠道、客户心理、客户维护、谈判技巧、团队管理等问题都做了详尽的阐述，并给出了行之有效的指导方法。',
'2015-09-01',25.80,'在库',7)