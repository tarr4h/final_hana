

create table test(
    no number,
    name varchar2(20)
);

commit;

select * from test;

insert into test values(3, '홍길동');
    