package models;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class Tweet implements Comparable<Tweet> {

	private Integer uid = null;
	private Integer tweetid = null;
	private String text = "";
	private Integer likes;
	private Integer retweets;
	private Integer comments;
	private Timestamp createdAt = null;
	private Integer parentTweet = null;
	private boolean isLiked = false; //Per saber si el tweet te un like del usuari que ha fet login. No existeix en el model de la bbdd s'assigna dinamicament.
	private boolean isRetweeted = false; //Per saber si el tweet te un retweet del usuari que ha fet login. No existeix en el model de la bbdd s'assigna dinamicament.
	private String username;
	private String retweetedBy = ""; //Per saber si es tracta d'un retweet. No existeix en el model de la bbdd s'assigna dinamicament.

	public Integer getUid() {
		return uid;
	}
	public void setUid(Integer uid) {
		this.uid = uid;
	}
	
	public Integer getTweetid() {
		return tweetid;
	}
	public void setTweetid(Integer tweetid) {
		this.tweetid = tweetid;
	}
	
	public String getText() {
		return text;
	}
	public void setText(String text) {
		this.text = text;
	}
	
	public Integer getLikes() {
		return likes;
	}
	public void setLikes(Integer likes) {
		this.likes = likes;
	}

	public Integer getRetweets() {
		return retweets;
	}
	public void setRetweets(Integer retweets) {
		this.retweets = retweets;
	}

	public Integer getParentTweet() {
		return parentTweet;
	}
	public void setParentTweet(Integer parentTweet) {
		this.parentTweet = parentTweet;
	}

	public boolean hasValue(String val) {
		return((val!=null) && (!"".equals(val)));
	}
	
	public Integer getComments() {
		return comments;
	}
	public void setComments(Integer comments) {
		this.comments = comments;
	}
	
	public String getDateConverted() {
		SimpleDateFormat sdf =  new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		return sdf.format(this.createdAt);
	}
	
	public Timestamp getCreatedAt() {
		return this.createdAt;
	}
	
	public void setCreatedAt(Timestamp createdAt) {
		this.createdAt = createdAt;
	}
	
	public boolean getIsLiked() {
		return this.isLiked;
	}
	
	public void setIsLiked(boolean isLiked) {
		this.isLiked = isLiked;
	}
	
	public boolean getIsRetweeted() {
		return this.isRetweeted;
	}
	
	public void setIsRetweeted(boolean isRetweeted) {
		this.isRetweeted = isRetweeted;
	}
	
	public String getUsername() {
		return this.username;
	}
	
	public void setUsername(String username) {
		this.username = username;	
	}
	
	public String getRetweetedBy() {
		return this.retweetedBy;
	}
	
	public void setRetweetedBy(String retweetedBy) {
		this.retweetedBy = retweetedBy;
	}
	@Override
	public int compareTo(Tweet o) {
		return this.getCreatedAt().compareTo(o.getCreatedAt());
	}
	
	/*public boolean isComplete() {
		return (this.hasValue(this.getUsername()) && this.hasValue(this.getContent()) && this.hasValue(this.getSecondName()) && this.hasValue(this.getPassword()) &&
				this.hasValue(this.getPasswordRepeat()) && this.hasValue(this.getMail()) && this.hasValue(this.getSex()) && this.hasValue(this.getAge()));
	}*/
	
	

	
	
	
}