
<<<<<<< HEAD
    
=======

create table test(
    no number,
    name varchar2(20)
);

commit;

select * from test;

insert into test values(3, '홍길동');
    
-- 소모임 생성 

-- 소모임 계정
create table group_(
    group_id varchar2(20) not null,
    group_name varchar2(30) not null,
    leader_id varchar2(20) not null,
    member_count number not null,
    board_count number not null, 
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

select * from group_;
>>>>>>> branch 'master' of https://github.com/tarr4h/final_hana.git
