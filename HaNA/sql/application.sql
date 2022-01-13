-- 테이블 생성
create table member (
    id varchar2(500) not null,
    password varchar2(500) not null,
    name varchar2(256) not null,
    picture varchar2(500),
    personal_id varchar2(300),
``  account_type number default 1,
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
