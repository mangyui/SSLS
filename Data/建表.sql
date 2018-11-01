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

--��1ͼ������Category
create table Category 
(
  Id int identity(1,1) primary key,
  Code NVarchar(50) not null,
  Name NVarchar(250) not null,
  [Description] NVarchar(1000),
)
go

--��2ͼ���Book
create table Book 
(
    Id int identity(1,1) primary key,
    Code NVarchar(50) not null,
    Name NVarchar(100) not null,
    Authors NVarchar(100) not null,
    Press NVarchar(100) ,   --������
    ImageUrl NVarchar(1000),
    [Description] NVarchar(2000),
    PublishDate DateTime,   --��������
    Price Decimal (18,2),
    [Status] NVarchar(100),   --״̬: δ�ڿ�,�ڿ�,���.
    Category_ID Int not null foreign key references Category(Id),
)
go 

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21001','��������','��',' ������ѧ������','/PImages/wx_fslj.jpg','����Ҫѧ���������۹⣬ȥ���������һ�С�������������������������ڽ�Ŀ��������Ƽ���һ���飡����׻������������������',2015-08-01,21.00,'�ڿ�',1)



--��3���߱�Reader
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

--��4���ı�Borrow
create table Borrow 
(
    Id int identity(1,1) primary key,
    Reader_ID Int not null foreign key references Reader(Id),
    Book_ID Int not null foreign key references Book(Id),
    BorrowDate DateTime not null,         --��
    ShouldDate DateTime not null,         --Ӧ��
    ReturnDate DateTime not null,         --ʵ��
    Renew NVarchar(100) not null check(Renew in('��','��')), 
)
go

--��5������ɱ�Fine
create table Fine 
(
    Id int identity(1,1) primary key,
    Borrow_ID Int not null foreign key references Borrow(Id),
    Reader_ID Int not null foreign key references Reader(Id), 
    OverDays Int not null,    --����
    Payment Decimal (18,2) not null, 
)
go

insert into Category(Code,Name) 
values('10001','��ѧ')
insert into Category(Code,Name) 
values('10002','��־')
insert into Category(Code,Name) 
values('10003','С˵')
insert into Category(Code,Name) 
values('10004','�ٶ�')
insert into Category(Code,Name) 
values('10005','��ʷ')
insert into Category(Code,Name) 
values('10006','����')
insert into Category(Code,Name) 
values('10007','�ڿ�')




insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21002','ƽ�������磨ȫ���ᣩ','·ң','����ʮ�����ճ�����','/PImages/wx_pfdsj.jpg',
'����һ����ʵ����С˵��Ҳ��С˵���ļ���ʷ�����Ҹ߶�Ũ�����й�����ũ�����ʷ��Ǩ���̣���Ʒ�ﵽ��˼�����������Եĸ߶�ͳһ���ر������˹�����������ܶ��ľ��񣬶Խ���Ĵ�ѧ�������������ϡ�',
'2013-12-1',45.00,'�ڿ�',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21003','�������3�����','����','�������ճ�����','/PImages/wx_jrgw3tgm.jpg',
'�������3�����(ȫ�뱾) ԭ�� ��ɾ�� ���׿����� ������ѧ���� �������ѧ������������ �������������鼮',
'2013-01-11',18.00,'�ڿ�',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21004','³��ѷƯ����','(Ӣ)��������Ѹ�|����:�����','����ʦ����ѧ������','/PImages/wx_lbxplj.jpg',
'��ŷ����ѧʷ�ľ�����Ʒ����ע��������������ð��֮�ã�����������ƴ������Ĺµ���ʿ��',
'2012-11-11',15.50,'�ڿ�',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21005','����Ϧʰ','³Ѹ','�й�����������','/PImages/wx_zhxs.jpg',
'����Ϧʰ ³Ѹ��Ʒ ������Ϧʰ��Ұ�ݼ���ƽ��� ³Ѹɢ�ļ� ³Ѹɢ��ʫ�� �������¿α��Ƽ���Ŀ �й��ֵ�����ѧ����',
'2016-03-11',14.50,'�ڿ�',1)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('21006','Χ��',' Ǯ����','������ѧ������','/PImages/wx_wc.jpg',
'Ǯ���������ġ�Χ�ǡ���һ������������������̬ͼ���������������ǧ����ζ�������еõ������쾡�µ����֡�',
'1991-02-11',23.80,'�ڿ�',1)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22001','��Ƥ��ȫ��','����ŵ��','�й���Ů������','/PImages/lz_jrgw3tgm.jpg',
'�ɹ�ʥ����ÿһ���������ϵ��˶�Ӧ��Ҫ�����飬����ʾ��ϣ�����Ƹ����ɹ�...',
'2015-01-01',25.20,'�ڿ�',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22002','���Ե�����',' ���������ͻ���','�㽭���ճ�����','/PImages/lz_rxdld.jpg',
'����Ѹ���������̺�̸�����ɵľ��䣡ȫ�³����뱾��δ���κ���ɾ�����������˼ʹ�ϵ��... ',
'2017-01-1',31.80,'�ڿ�',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22003','���ѧ����ȫ��','������',' ���ݳ�����','/PImages/lz_hhxqj.jpg',
'���ѧ����ȫ�� ������ԭ���ɹ�ѧ˵�����¾���ְ��������ѧȫ�� �������ľ���������˼ʹ�ϵС˵��ҵ�鼮��־�ɹ��鼮',
'2009-01-11',35.20,'�ڿ�',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22004','�������������ɵ�','�з��ж�˹̩��','�й�����������','/PImages/lz_gtszylcd.jpg',
'���羭����ѧ����С˵�����鼮',
'2012-11-11',16.80,'�ڿ�',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22005','��������','��ܾ','������������','/PImages/lz_jldn.jpg',
'��������һ�����л����ƴ�����Լ� ������ɹ��������ഺ��־��ѧС˵���鼦��������ѧŮ����ľ�����鼮',
'2017-03-01',29.80,'�ڿ�',2)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('22006','�ڶ���','[Ӣ]����������˸���','�ٻ������ճ�����','/PImages/lz_bdr.jpg',
'���������һ���¶��ĺ�����˭���������İڶ��ˣ�',
'2015-06-01',25.80,'�ڿ�',2)



insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23001','�����ȫ����·��',' �żμ�',' �������ճ�����','/PImages/xs_cndqsjlg.jpg',
'���������Ķ��Ĺ���...',
'2013-11-01',23.80,'�ڿ�',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23002','����','�໪','���ҳ�����','/PImages/xs_hz.jpg',
'�����š�������ũ���˸��󱯲ҵ����������������Ǹ�����ү�������ȶ����������ڶĹ��˼�ҵ��һƶ��ϴ... ',
'2012-08-1',31.80,'�ڿ�',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23003','�˲���ĸǴı�','�ƴĽ�����','�������ճ�����','/PImages/xs_lbqdgcb.jpg',
'С˵ͨ��������������ʽ����д��20������Ʊ� �����Ǵı���׷��ġ������Ρ��Ļ��𣬽�ʾ���������ı��硣',
'2012-01-11',35.20,'�ڿ�',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23004','�����ӻ���','��Ұ����','���߳�����','/PImages/xs_jyzhd.jpg',
'���ǽ�����д����Ͷ���ӻ��꣬����������漴���Ϸ����������е�һ��żȻ���ᣬ������������Ȼ��ͬ��������',
'2014-05-01',37.80,'�ڿ�',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23005','����','·ң','����ʮ�����ճ�����','/PImages/xs_rs.jpg',
'�ĸ�ʱ���±���ԭ�ĳ�������Ϊʱ�ձ����������˸��б�ҵ���߼��ֻص��������뿪���أ��ٻص��������������ı仯���̡�',
'2012-03-01',17.00,'�ڿ�',3)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('23006','����ǰҹ','��Ұ����','���߳�����','/PImages/xs_jmqy.jpg',
'�Ǳ������棬���ǽҿ����棬����ְ�����˵ľƵ�ǰ̨ɽ��������������̾�����ƽ�����Ӧ�ԣ�4��������ʡ�Ĺ��½������𰸡�',
'2016-02-29',30.50,'�ڿ�',3)



insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24001','�����ռ�','(��)���ա���������','���������','/PImages/sr_qydrj.jpg',
'�����ռǻ汾����汾����ռǶ�ͯ�汾0-3-4-6�����׶��鼮ͼ���׶�԰ͼ���鱦�����ɹ�����',
'2013-04-01',16.80,'�ڿ�',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24002','����ͯ��','[��]�Ÿ���������','�����ѧ���о�������','/PImages/sr_glth.jpg',
'��Щͯ�������������ӣ�������죬������̡����������Ķ���Щͯ����ʱ�򣬾��������������̽�����һ�����ܴ��и��ܵ�19�������ǵľ������硣',
'2012-01-1',11.80,'�ڿ�',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24003','ͯҥ������','����','���������ͯ������','/PImages/sr_ty300s.jpg',
'ͯҥ���ּ򵥡��������ɡ���ѧ�׼ǡ������Ͽڣ��Ƿǳ����϶�ͯ�Ķ��ص�������������ѧ��ʽ��',
'2015-02-01',17.80,'�ڿ�',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24004','��ͽ��ͯ��','��ͽ��','�����ͳ�����','/PImages/sr_atsth.jpg',
'Ϊ����Ӫ���������ǵ�ͯ������ ',
'2014-09-01',18.80,'�ڿ�',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24005','һǧ��һҹ','����','�����ͳ�����','/PImages/sr_1001y.jpg',
'Ϊ����Ӫ���������ǵ�ͯ������ ',
'2014-09-01',18.80,'�ڿ�',4)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('24006','����Ԣ��','����','�����ͳ�����','/PImages/sr_ysyy.jpg',
'Ϊ����Ӫ���������ǵ�ͯ������ ',
'2014-09-01',18.80,'�ڿ�',4)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25001','�ڶ��������սȫʷ','�׺�','�й����ȳ�����','/PImages/ls_2z.jpg',
'�ع�ս���������Ƕ�Ѫ������ʷ���������Էḻ��ʷ֪ʶ�����ܹ���ʷΪ������ȡ��ѵ���̶�����̽��ս�����ƽ��һ������ʷ���������⡣',
'2016-01-01',21.50,'�ڿ�',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25002','�й�ͨʷ','�λ�','�й����ȳ�����','/PImages/ls_zgts.jpg',
'����һ�������й���ʷ�Ķ��ȫ�淴ӳ�˴Ӵ�˵ʱ�����峯��������ʷȫ����ͬʱ���л��������й����¼ǡ�������¼ǵȶ��֪ʶ��顣',
'2016-01-1',21.50,'�ڿ�',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25003','����ͨ��','˾���','������Ů��ͯ������','/PImages/ls_zztj.jpg',
'������ͨ�������ҹ��Ŵ�������ʷѧ�ҡ����μ�˾��������������ʱʮ��������һ����ģ��ǰ�ı�����ͨʷ������',
'2015-01-01',14.80,'�ڿ�',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25004','�����ʷͦ����','Ԭ�ڷ�','�������������','/PImages/ls_zglstkp.jpg',
'����ʷ�Ǹ�ʲô�������ϵ�е�������ذ档��ϵ�п���ȫ���ʷ�³�����������������������',
'2013-07-01',62.70,'�ڿ�',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25005','ʷ��','˾��Ǩ','�й����ȳ�����','/PImages/ls_sj.jpg',
'��ѡ������*�ߴ�������*���ʵ�ƪ�¼�¼���飬�������˴���������ͼ�����������ʵ��ֱ�ۡ�ȫ��ؽ��й���ʷ�ķḻ�뾫�ʳ����ڶ�����ǰ',
'2014-10-01',29.80,'�ڿ�',5)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('25006','һ�����������Ȥ������','��ƽ','�������ϳ��湫˾','/PImages/ls_ybs.jpg',
'��֪ʶ�Ժ�Ȥζ��Ϊ��ּ��ȫ��λ����Ƕȵ�չʾ�����ص����ʱ��*���о���ֵ��*Ϊ��������ע��Ȥ������',
'2014-11-01',26.80,'�ڿ�',5)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26001','����ѧϰ��Ŀ����ʵ��',' [��]Mathias Brandewinder(�����˹���������µ¶�)','�����ʵ������','/PImages/js_jqxx.jpg',
'�Ա�����Ķ�����������Ӵ��������ѧ֪ʶ����ɿ������֣�Ϊ�պ�Ŀ����������¼�ʵ�Ļ���',
'2016-01-01',21.50,'�ڿ�',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26002','���ѧϰ-������Ӧ��','л��','����������','/PImages/js_sdxx.jpg',
'�Ȿ������ѧϰ�����Լ����ڸ����ź�����Ϣ���������е�Ӧ�ý����˸���',
'2016-04-1',31.80,'�ڿ�',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26003','�������','[��]�Ƕ���������','�����ʵ������','/PImages/js_bczj.jpg',
'�������ɫ��ͨ��һЩ������Ƶ���Ȥ�����ľ�ָ������ĳ��򣬶�ʵ�ó�����Ƽ��ɼ��������ԭ�������͸������ǵ�������',
'2015-01-01',37.40,'�ڿ�',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26004','Java�����ŵ���ͨ','���տƼ�','�廪��ѧ������','/PImages/js_java.jpg',
'�ӳ�ѧ�߽Ƕȳ�����ͨ��ͨ���׶������ԡ��ḻ��ʵ�ʵ������ϸ������ʹ��Java���Խ��г��򿪷���Ҫ���յ�֪ʶ��',
'2012-09-01',52.60,'�ڿ�',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26005','��Ӧ�õ�����','���','���ӹ�ҵ������','/PImages/js_cyydcx.jpg',
'�ֻ�Ӳ���з������ ��������һ�߹���ʦ׫д����ϸ�����ֻ�Ӳ���з�����Ƶ�רҵͼ��',
'2016-10-01',78.20,'�ڿ�',6)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('26006','��0��1',' �˵õٶ�|��������˹��˹','���ų�����','/PImages/js_c0d1.jpg',
'������ҵ��δ�������� һλ����Ĵ�Ͷ�̸���һ���������ܵ���ҵ֮����һ���¹������˵�������ѧ ',
'2015-01-29',27.00,'�ڿ�',6)


insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27001','����������+','����|����|�ߺ��','���ų�����','/PImages/qk_ddhlw.jpg',
'�����ơ��������ߺ�����𽨺��������ʵ���,�����˹���**����ҵ�ҡ�ѧ�� ���������ڴ��µ���ҵ���о����������ʵ������ �������о�������������ȫ��ľ��÷�չ���ơ�һ ���������������+����',
'2015-07-01',35.50,'�ڿ�',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27002','ǹ�ڡ����������','���ɵ�','�Ϻ����ĳ�����','/PImages/qk_qbg.jpg',
'���ⲿ�����Ե������У��ݻ�����ѧ�ҡ�����ѧ�Ҽ��׵´��ɵ½�ʾ����ʵ���������γ���ʷ��㷺ģʽ�Ļ������أ��Ӷ��������ĵ������ݻ�������������Ϊ����������ʷ���ۡ�',
'2016-07-1',31.80,'�ڿ�',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27003','Ӱ����',' (��)�޲���','�������ϳ��湫˾','/PImages/qk_yxl.jpg',
'�����ڳ嶯��˳��������Ϊ�����6���������ţ�������һ�еĸ�Դ����ЩȰ˵�����ǣ������������������ǣ������Ǿͷ���',
'2016-09-01',49.00,'�ڿ�',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27004','���װ;�Ӫ','(��)ɭ��ֱ��','��е��ҵ������','/PImages/qk_ambjy.jpg',
'�����˰��װ;�Ӫ��ʵս�����Ͱ�����������ҵ���˵�Ǳ�����޵ؼ���������',
'2015-07-01',23.00,'�ڿ�',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27005','���¾���,��������','������','�������ϳ��湫˾','/PImages/qk_syjh.jpg',
'����������������������һ������ɢ�ļ������������֣���Զ��˼�룬�����м��г����������������߽��ճ�������ƽ�������С�������չʾ��ƽ����˽�Ĵ��ǻۡ�',
'2016-12-01',27.20,'�ڿ�',7)

insert into Book(Code,Name,Authors,Press,ImageUrl,[Description],PublishDate,Price,[Status],Category_ID) 
values('27006','���۾���Ҫ��ת����','����˹̹��','�人������','/PImages/qk_xsjs99.jpg',
'99%���˶���֪������������,��������̳�������������ҵ�г����������������ͻ������ͻ�ά����̸�м��ɡ��Ŷӹ�������ⶼ�����꾡�Ĳ���������������֮��Ч��ָ��������',
'2015-09-01',25.80,'�ڿ�',7)