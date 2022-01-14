

create table test(
    no number,
    name varchar2(20)
);

commit;

select * from test;

drop table test;

insert into test values(3, '홍길동');
delete from test where no = 3;

select * from member;

drop table member;

commit;

commit;