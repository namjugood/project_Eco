-- disconnect key
alter table member drop primary key cascade;
alter table admin drop primary key cascade;
alter table artist drop primary key cascade;
alter table album drop primary key cascade;
alter table bundle_master drop primary key cascade;
alter table music drop primary key cascade;
alter table theme drop primary key cascade;
alter table chart drop primary key cascade;
alter table genre drop primary key cascade;
alter table qna drop primary key cascade;
alter table adminqna drop primary key cascade;

-- drop table
drop table notice purge;
drop table qreply purge;
drop table qna purge;
drop table music_ban purge;
drop table music_like purge;
drop table album_like purge;
drop table artist_like purge;
drop table music_reply purge;
drop table music purge;
drop table album purge;
drop table artist purge;
drop table theme purge;
drop table chart purge;
drop table genre purge;
drop table bundle_master purge;
drop table bundle_detail purge;
drop table admin purge;
drop table member purge;
drop table adminqna purge;

-- drop sequence
drop sequence member_seq;
drop sequence admin_seq;
drop sequence music_seq;
drop sequence theme_seq;
drop sequence chart_seq;
drop sequence genre_seq;
drop sequence music_reply_seq;
drop sequence album_seq;
drop sequence artist_seq;
drop sequence qna_seq;
drop sequence notice_seq;
drop sequence qreply_seq;
drop sequence bundle_master_seq;
drop sequence bundle_detail_seq;
drop sequence adminqna_seq;

-- create sequence
create sequence member_seq start with 1;
create sequence admin_seq start with 1;
create sequence music_seq start with 1;
create sequence theme_seq start with 1;
create sequence chart_seq start with 1;
create sequence genre_seq start with 1;
create sequence music_reply_seq start with 1;
create sequence album_seq start with 1;
create sequence artist_seq start with 1;
create sequence qna_seq start with 1;
create sequence notice_seq start with 1;
create sequence qreply_seq start with 1;
create sequence bundle_master_seq start with 1;
create sequence bundle_detail_seq start with 1;
create sequence adminqna_seq start with 1;

-- create table
create table member(
	useq number(5) primary key,
	id varchar2(50) unique not null,
	pw varchar2(20) not null,
	name varchar2(30) not null,
	phone varchar2(13) unique not null,
	gender varchar2(1) not null,
	membership varchar2(1) default 'N' not null, -- 이용권 여부 Y, N 
	sdate date default sysdate,	-- 이용권 시작일
 	edate date default sysdate, -- 이용권 만료일
	indate date default sysdate
);

create table admin(
	aseq number(3) primary key,
	id varchar2(20) not null,
	pw varchar2(20) not null
);

-- 관리자가 곡 추가시 테마/태그를 추가하여 번들제작시 효율적으로 관리하기 위함
create table theme(
	tseq number(5) primary key,
	title varchar2(100) unique not null,
	img varchar2(100)
);

--flo 차트 지금 급상승 중 해외 소셜 차트 ...
create table chart(
	cseq number(5) primary key,
	title varchar2(100) unique not null,
	img varchar2(100)
);

-- 국내 발라드 해외 팝 국내 댄스/일렉 국내 알앤비 국내 힙합 트로트 해외 알앤비 해외 힙합 ost/bgm 키즈 국내 인디 클래식 뉴에이지 국내 팝/어쿠스틱 해외 일렉트로닉 ccm 시원한 감성적인 슬픈 기쁜 댄스 발라드 ...
create table genre(
	gseq number(5) primary key,
	title varchar2(100) unique not null,
	img varchar2(100)
);

create table artist (
	atseq number(5) primary key,
	name varchar2(30) not null,
	groupyn varchar2(1) not null, -- y: 그룹, n: 솔로
	gender varchar2(1) not null, -- m: 남성, f: 여성, a: 혼성
	gseq number(5) references genre(gseq),
	img varchar2(300),
	description varchar2(1000)
);

create table album (
	abseq number(5) primary key,
	atseq number(5) references artist(atseq),
	title varchar2(100) not null,
	img varchar2(500),
	content varchar2(4000),
	abtype varchar2(20), -- 정규, 미니, 싱글, ost, 디지털싱글
	gseq number(5) references genre(gseq),
	pdate date not null -- 앨범 발매일 필수
);

create table music(
	mseq number(5) primary key,
	abseq number(5) references album(abseq),
	atseq number(5) references artist(atseq),
	theme varchar2(1000), -- 테마/태그(복수) 구분자: |
	chart varchar2(100), 					-- 차트(복수) 구분자: |
	gseq number(5) references genre(gseq), 	-- 장르(단일)
	title varchar2(300) not null,
	content varchar2(4000), 				-- 가사
	titleyn varchar2(1), 					-- y: 타이틀, n: 일반
	musicby varchar2(500),					-- 작곡
	lyricsby varchar2(500),					-- 작사
	producingby varchar2(500),				-- 편곡
	src varchar2(200) 						-- 음악 재생경로
);

-- 사이트 또는 유저의 리스트
create table bundle_master (
	bmseq number(5) primary key,
	useq number(5) not null, -- 0: 관리자에서 추가한 리스트, 유저시퀀스: 유저의 개인 리스트
	title varchar2(300),
	useyn varchar2(1) default 'Y', -- 사용여부 (사이트내의 리스트일 경우에만 핸들링)
	cdate date default sysdate
);

-- 사이트 또는 유저의 리스트에 들어갈 곡
create table bundle_detail(
	bdseq number(5) primary key,
	bmseq number(5) references bundle_master(bmseq),
	mseq number(5) references music(mseq)
);

create table music_like(
	useq number(5) references member(useq),
	mseq number(5) references music(mseq),
	cdate date default sysdate,
	constraint music_like_pk primary key (useq, mseq) -- primary key(member.useq와 music.mseq를 조합한 복합키)
);

create table album_like(
	useq number(5) references member(useq),
	abseq number(5) references album(abseq),
	cdate date default sysdate,
	constraint album_like_pk primary key (useq, abseq) -- primary key(member.useq와 album.abseq를 조합한 복합키)
);

create table artist_like(
	useq number(5) references member(useq),
	atseq number(5) references artist(atseq),
	cdate date default sysdate,
	constraint artist_like_pk primary key (useq, atseq) -- primary key(member.useq와 artist.atseq를 조합한 복합키)
);

create table music_reply(
	rseq number(5) primary key,
	mseq number(5) references music(mseq),
	useq number(5) references member(useq),
	content varchar2(1000) not null,
	wdate date default  sysdate
);

create table music_ban(
	useq number(5) references member(useq),
	mseq number(5) references music(mseq),
	cdate date default sysdate,
	constraint music_ban_pk primary key (useq, mseq) -- primary key(member.useq와 music.mseq를 조합한 복합키)
);

create table qna (
	qseq number(5) primary key,
	useq number(5) references member(useq),
	title varchar2(200) not null,
	content varchar2(3000),
	qna_date date default  sysdate
);

create table qreply (
	qrseq number(5) primary key,
	qseq number(5) references qna(qseq),
	aseq number(5) references admin(aseq),
	useq number(5) references member(useq),
	content varchar2(3000),
	qreply_date date default  sysdate
);

create table notice (
	nseq number(5) primary key,
	title varchar2(200) not null,
	content varchar2(3000),
	notice_date date default  sysdate
);

create table adminqna (
	adqseq number(5) primary key,
	title varchar2(200) not null,
	content varchar2(1000),
	adqna_date date default  sysdate
);

-- 테이블설명 
comment on table member is '사용자';
comment on table admin is '관리자';
comment on table theme is '테마/태그';
comment on table chart is '차트';
comment on table genre is '장르';
comment on table artist is '아티스트';
comment on table album is '앨범';
comment on table music is '곡';
comment on table bundle_master is '리스트 마스터';
comment on table bundle_detail is '리스트 상세';
comment on table music_like is '곡 좋아요';
comment on table album_like is '앨범 좋아요';
comment on table artist_like is '아티스트 좋아요';
comment on table music_reply is '곡 댓글';
comment on table music_ban is '곡 차단';
comment on table qna is '질문';
comment on table qreply is '답변';
comment on table notice is '공지사항';

-- 뷰 정의

create or replace view music_view -- 뮤직
as
select
    m.mseq
    , m.title
    , m.content
    , m.theme
    , m.chart
    , m.gseq
    , m.titleyn
    , m.src
    , m.musicby
    , m.lyricsby
    , m.producingby
    , ab.abseq
    , ab.title as abtitle
    , ab.img as abimg
    , ab.content as abcontent
    , ab.pdate as pdate
    , ab.abtype
    , ab.gseq as abgseq
    , at.atseq
    , at.name
    , at.groupyn
    , at.gender
    , at.gseq as atgseq
    , at.img as atimg
    , at.description
    , g.title as gtitle
	, mpopular.rank -- 인기 순위(좋아요 수 > 음악시퀀스)
    , mpopular.likecount -- 좋아요 수
from music m
    left join album ab
        on m.abseq = ab.abseq
    left join artist at
        on at.atseq = m.atseq and at.atseq = ab.atseq
    left join genre g
        on g.gseq = at.gseq
    left join (
        select
            m.mseq -- 음악시퀀스
            , rank() over (
                order by
                    nvl(musiclike.likecount, 0) desc -- 순위측정 첫번재 우선순위 : 좋아요 수 내림차순(likecount없으면 0으로 변경 후 순위측정)
                    , m.mseq desc                   -- 순위측정 두번째 우선순위 : 음악시퀀스 내림차순
                ) as rank -- 순위
            , nvl(musiclike.likecount, 0) as likecount -- 좋아요 수(없으면 0)
        from music m
            left join (
                select mseq, count(*) as likecount from music_like group by mseq
            ) musiclike on musiclike.mseq = m.mseq
    ) mpopular -- 음악 인기순위 (좋아요 수 > 음악시퀀스)
        on mpopular.mseq = m.mseq;

create or replace view album_view -- 앨범
as
select 
    ab.abseq
    , ab.title
    , ab.img
    , ab.content
    , ab.pdate
	, ab.abtype
	, ab.gseq
    , abg.title as abgenre
    , at.atseq
    , at.name
    , at.groupyn
    , at.gender
    , at.gseq as atgseq
    , at.img as atimg
    , at.description
	, atg.title as atgenre
    , abpopular.rank -- 인기순위 (좋아요 수 > 발매일 최신순 > 앨범시퀀스)
    , abpopular.likecount -- 좋아요 수
	, nvl(mucountbyalbum.mucount, 0) as mucount -- 음악수
from album ab
    left join artist at
    	on at.atseq = ab.atseq
    left join genre abg
        on abg.gseq = ab.gseq
	left join genre atg
		on atg.gseq = at.gseq
    left join (
        select
            ab.abseq
            , rank() over (
                order by
                    nvl(albumlike.likecount, 0) desc -- 순위측정 첫번째 좋아요수
                    , ab.pdate desc -- 순위측정 두번째 발매일최신순(null일 경우 순위 겹침)
                    , ab.abseq desc -- 순위측정 세번째 앨범시퀀스
                ) as rank
            , nvl(albumlike.likecount, 0) as likecount
        from album ab
            left join (
                select abseq, count(*) as likecount from album_like group by abseq
            ) albumlike -- 앨범당 좋아요 수
                on albumlike.abseq = ab.abseq
    ) abpopular -- 앨범 인기순위(좋아요수 > 발매일 > 앨범시퀀스)
        on abpopular.abseq = ab.abseq
	left join (
		select count(*) as mucount, abseq from music group by abseq
	) mucountbyalbum -- 앨범별 곡수
		on mucountbyalbum.abseq = ab.abseq;

create or replace view artist_view -- 아티스트
as
select 
    at.atseq
	, at.name
	, at.groupyn
	, at.gender
	, at.gseq
	, at.img
	, at.description
	, g.title as atgenre
    , atpopular.rank -- 인기순위 (좋아요 수 > 아티스트 시퀀스)
    , atpopular.likecount -- 좋아요 수
	, nvl(abcountbyartist.abcount, 0) as abcount -- 앨범수
	, nvl(mucountbyartist.mucount, 0) as mucount -- 음악수
from artist at
	left join genre g
		on g.gseq = at.gseq
    left join (
        select
            at.atseq
            , rank() over(
                order by
                    nvl(artistlike.likecount, 0) desc -- 순위측정 첫번째 좋아요수
                    , at.atseq desc -- 아티스트등록 순서
            ) as rank
            , nvl(artistlike.likecount, 0) as likecount
        from artist at
            left join (
                select atseq, count(*) as likecount from artist_like group by atseq
            ) artistlike -- 아티스트 좋아요 수
                on artistlike.atseq = at.atseq
    ) atpopular -- 아티스트 인기순위(좋아요 수 > 아티스트 시퀀스)
        on atpopular.atseq = at.atseq
	left join (
		select count(*) as abcount, atseq from album group by atseq
	) abcountbyartist -- 아티스트별 앨범수
		on abcountbyartist.atseq = at.atseq
	left join (
		select count(*) as mucount, atseq from music group by atseq
	) mucountbyartist -- 이티스트별 곡수
		on mucountbyartist.atseq = at.atseq;

create or replace view likemusic_view
as
select 
    m.mseq
    , m.title
    , m.gseq
    , ab.abseq
    , ab.img as abimg
    , ab.title as abtitle
    , at.atseq
    , at.name
    , ml.useq
    , ml.cdate
from music m, music_like ml, album ab, artist at
where m.mseq = ml.mseq and ab.abseq = m.abseq and at.atseq = ab.atseq;

select * from likemusic_view;

create or replace view likeartist_view
as
select 
    at.atseq
	, at.name
	, at.groupyn
	, at.gender
	, at.gseq
	, g.title as atgenre
	, at.img
	, al.useq
	, al.cdate
	from artist at, artist_like al, genre g
	where al.atseq = at.atseq and g.gseq = at.gseq;

select * from likeartist_view;

create or replace view likealbum_view
as
select 
    ab.abseq
    , ab.atseq
    , ab.title
    , ab.img
	, ab.pdate
	, ab.abtype
	, at.name
	, g.title as abgenre
	, at.gseq
	, abl.useq
	, abl.cdate
	from album ab, album_like abl, artist at, genre g
	where abl.abseq = ab.abseq and ab.atseq = at.atseq and g.gseq = ab.gseq;

create or replace view qna_view as
select 
    q.qseq
    , q.useq
	, q.title
	, q.content as qnacontent
	, q.qna_date
	, qr.qrseq
	, qr.content as replycontent
	, qr.qreply_date
	from qna q left join qreply qr on q.useq = qr.useq and q.qseq = qr.qseq;
select * from qna_view;

create or replace view bundle_view
as
select 
	bm.*
	, (select count(*) from bundle_detail where bmseq = bm.bmseq) as mucount
from bundle_master bm
where bm.useq = 0;