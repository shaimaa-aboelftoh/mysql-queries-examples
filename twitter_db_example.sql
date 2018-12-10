#create db
create database if not exists `twitter`;

#drop db
#drop database if exists `twitter`;

######################################################33333333333

#build schema
	use twitter;
	
    #users table
    create table users(
		id integer unsigned auto_increment primary key,
		username varchar(50),
        created_at timestamp default now()
    );
    
	#drop table if exists `users`;

	#tweets table
    create table `tweets`(
		id integer auto_increment primary key,
        body text not null,
		user_id integer,
        created_at timestamp default now(),
        foreign key (user_id) references users(id) on delete cascade
    );
	
    #drop table if exists `tweets`;

	#replies table 
    create table if not exists `replies`(
		id integer auto_increment primary key,
        body text not null,
        user_id int,
        tweet_id int,
        created_at timestamp default now(),
        foreign key (user_id) references users(id) on delete cascade,
        foreign key (tweet_id) references tweets(id) on delete cascade
    );
    
    #drop table if exists `replies`;
    
    #likes table
    create table if not exists `likes`(
		id integer auto_increment primary key,
        user_id integer,
        tweet_id integer,
        created_at timestamp default now(),
        foreign key (user_id) references users(id) on delete cascade,
        foreign key (tweet_id) references tweets(id) on delete cascade
    );
    
    # drop table if exists `likes';

######################################################33333333333

#insert data
	#users
    insert into `users` (username)
			values ('jane'),( 'alex'),('jone'),('malek'),('windy');
	#truncate users
    
	#tweets 
    insert into `tweets` (body,user_id)
			values ('hello world', 1) ,
					('thanks so much', 1) ,
                    ('welcome to mysql', 2) ,
                    ('have a nice day',2 ) ,
                    ('try again', 3) ; 
	#truncate tweets;

	#relpies
    insert into `replies` (body,user_id,tweet_id)
			values  ('hiiiiii', 2,1 ) , 
					('you are welcome', 4,2 ) , 
					('not at all', 3, 2) , 
					('you too', 3,4) , 
					('thanks', 1,4 ) , 
					('i will', 5, 5) ,
                    ('okey', 4, 5) ;
	#truncate replies;

	#likes
    insert into likes (user_id,tweet_id)
			values ( 2, 1), 
					( 4,2 ), 
                    ( 5, 2), 
                    ( 3, 4), 
                    ( 5, 1), 
                    ( 3, 2) ;
	
    #truncate likes;

######################################################33333333333

#show data

	#all data
select * from users;
select * from tweets;
select * from replies;
select * from likes;

	#user tweets
select 
	tweets.id as tweetID  ,
    tweets.body as tweet,
    users.username as userName ,
    users.id as userID,
    tweets.created_at as tweetDate
from `tweets`
join users on tweets.user_id = users.id
order by tweets.id desc;

	# replies
select 
	replies.body as reply,
    users.username as replyBy,
    tweets.body as tweet
from `replies`
join users on replies.user_id = users.id
join tweets on replies.tweet_id= tweets.id;

	# tweet replies
select
	tweets.id as 'tweetID',
	tweets.body as 'tweet',
    replies.body as 'reply',
    users.username as 'replyBy'
from `tweets`
join replies on replies.tweet_id = tweets.id
join users on replies.user_id = users.id
order by tweets.id desc;

	# tweet likes
select 
	count( likes.tweet_id ) as total_likes,
    tweets.body as tweet
from `likes`
join tweets on likes.tweet_id= tweets.id
group by likes.tweet_id;