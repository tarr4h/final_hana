-- 테이블 생성
create table member (
    id varchar2(500) not null,
    password varchar2(500) not null,
    name varchar2(256) not null,
    picture varchar2(500),
    personal_id varchar2(300),
    account_type number default 1,
    address varchar2(500) not null,
    introduce varchar2(512),
    enabled number default 1,   -- 회원활성화여부 1:활성화됨, 0:비활성화(spring-security)
    constraint pk_member_id primary key(id),
    constraint ck_member_enabled check(enabled in (1, 0)),
    constraint ck_member_account_type check(account_type in (1, 0))
);
create table group_(
    group_id varchar2(20) not null,
    group_name varchar2(30) not null,
    leader_id varchar2(20) not null,
    member_count number default 1,
    board_count number default 0, 
    hashtag varchar2(4000),
    image varchar2(500),
    constraint pk_group_id primary key(group_id),
    constraint fk_leader_id foreign key(leader_id) references member(id) on delete cascade
);
drop table group_;
drop table member;

commit;

select * from test;

drop table test;

insert into test values(3, '홍길동');

delete from test where no = 3;

select * from member;

drop table member;

commit;

commit;

    
-- 소모임 생성 


drop table group_;
-- 소모임 계정
create table group_(
    group_id varchar2(20) not null,
    group_name varchar2(30) not null,
    leader_id varchar2(20) not null,
    member_count number default 1,
    board_count number default 0, 
    hashtag varchar2(4000),
    image varchar2(500),
    constraint pk_group_id primary key(group_id),
    constraint fk_leader_id foreign key(leader_id) references member(id) on delete cascade
);

-- 소모임 게시물
create table group_board(
    no number not null,
    group_id varchar2(20) not null,
    writer varchar2(20) not null,
    content varchar2(4000) not null,
    reg_date date default sysdate,
    like_count number not null,
    image varchar2(500) not null,
    constraint pk_group_board_no primary key(no),
    constraint fk_group_id foreign key(leader_id) references member(id) on delete cascade
);

select * from member;
select * from group_;
insert into member values(
    'hyungzin0309','1234','김형진',null,'960309-1000000',default,'경기도','성남시','판교대장로7길 16 ','603동 1202호 ','안녕하세요',default
);
select * from group_;
insert into group_ values(
    'ss','축구','hyungzin0309',default,default,null,null
);
commit;


select * from group_;
delete from group_;
