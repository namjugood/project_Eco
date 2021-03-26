select * from music_view order by mseq desc;


select 
    m.mseq
    , m.title
    , m.content
    , m.gseq
    , m.titleyn
    , m.theme
    , ab.abseq
    , ab.title as abtitle
    , ab.img as abimg
    , ab.content as abcontent
    , ab.pdate as pdate
    , at.atseq
    , at.name
    , at.groupyn
    , at.gender
    , at.gseq as atgseq
    , at.img as atimg
    , at.description as genre
from music m
    left join album ab
    on m.abseq = ab.abseq
    left join artist at
    on at.atseq = m.atseq and at.atseq = ab.atseq;


select * from music_view;

select * from album_view;

select * from bundle_master;

select * from music_view where theme like '%'||3||'%'
		order by mseq desc;



select * from BUNDLE_MASTER;
select * from BUNDLE_DETAIL;

select 
	at.*
	, g.titl as gtitle
from artist at
	join genre g
		on at.gseq = g.gseq;
		
select * from member;

-- 특정유저가 좋아요를 누른 곡목록을 최신별로 조회  
select * from
music m, album ab, artist at, music_like ml
where
    m.abseq = ab.abseq
    and m.atseq = at.atseq
    and ml.mseq = m.mseq
and ml.useq = 1
order by cdate desc;

-- 좋아요한 음악들을 유저별 생성시간별로 정렬하여 조회
select * from music_like order by useq desc, cdate desc;

update album set pdate = sysdate;

select * from album_like;

insert into ALBUM_LIKE(useq, abseq) values(1, 3);

select 
    at.atseq
	, at.name
	, at.groupyn
	, at.gender
	, at.gseq
	, at.img
	, at.description
	, g.title as genre
from artist at
	left join genre g
		on g.gseq = at.gseq;

-- 인기순 뮤직(좋아요 기록된 음악만)
select
    rank() over (order by mlikerank.likecount desc, mlikerank.mseq desc) as likerank
    , mlikerank.likecount as likecount
    , mv.*
from (select mseq, count(*) as likecount from music_like group by mseq) mlikerank
    left join music_view mv
        on mv.mseq = mlikerank.mseq
order by likerank asc;

-- 인기순 앨범(좋아요 기록된 앨범만)
select
    rank() over (order by ablikerank.likecount desc, ablikerank.abseq desc) as likerank
    , ablikerank.likecount as likecount
    , abv.*
from (select abseq, count(*) as likecount from album_like group by abseq) ablikerank
    left join album_view abv
        on abv.abseq = ablikerank.abseq
order by likerank asc;

-- 인기순 아티스트(좋아요 기록된 아티스트만)
select
    rank() over (order by atlikerank.likecount desc, atlikerank.atseq desc) as likerank
    , atlikerank.likecount as likecount
    , atv.*
from (select atseq, count(*) as likecount from artist_like group by atseq) atlikerank
    left join artist_view atv
        on atv.atseq = atlikerank.atseq;

select * from music_view;
select * from album_view;
select * from artist_view;

select * from music_view where atseq = 4
order by rank asc;

select * from album_view where atseq = 4;

select * from album;
select * from member;

select  from music_view;


UPDATE MEMBER SET MEMBERSHIP = 'N' where useq = 1;
select * from notice;