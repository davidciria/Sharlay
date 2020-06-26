package managers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import utils.DAO;
import utils.SortTweetsByTime;
import models.Tweet;
import models.User;


public class ManageTweet {
	
	private DAO db = null;

	public ManageTweet() {
		try {
			db = new DAO();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void finalize() {
		try {
			super.finalize();
			db.disconnectBD();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	public void insertTweet(Tweet tweet) throws Exception{
		
		String query = "INSERT INTO Tweets (uid,text,likes,retweets,comments,createdAt,parentTweet) VALUES (?,?,?,?,?,?,?)";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, tweet.getUid());
			statement.setString(2, tweet.getText());
			statement.setInt(3, tweet.getLikes());
			statement.setInt(4, tweet.getRetweets());
			statement.setInt(5, tweet.getComments());
			statement.setTimestamp(6, tweet.getCreatedAt());
			if(tweet.getParentTweet() == null) {
				statement.setNull(7, java.sql.Types.NULL);
			}else {
				statement.setInt(7, tweet.getParentTweet());
			}
			statement.executeUpdate();
			statement.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		
		String query3 = "UPDATE Users SET tweets = tweets + 1 WHERE uid = ?"; //Afegim un al contador de tweets del usuari.
		PreparedStatement statement3 = null; //Afegir el tweet a la pagina del user que ha retuitejat.

		try {
			statement3 = db.prepareStatement(query3);
			statement3.setInt(1, tweet.getUid());
			statement3.executeUpdate();
			statement3.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	}
	
	//Aquesta funcio s'ha de revisar !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	public List<Tweet> getTweet(Integer tweetid) throws Exception {

		List<Tweet> tweets = new ArrayList<Tweet>();
	
		String query = "SELECT * FROM Tweets WHERE tweetid = ? ORDER BY createdAt DESC";

		PreparedStatement statement = null;
		
		statement = db.prepareStatement(query);
		statement.setInt(1, tweetid);
		
		ResultSet rs = statement.executeQuery();

		while (rs.next()) {
	      Tweet tweet = new Tweet();
	      tweet.setUid(rs.getInt("uid"));
	      tweet.setTweetid(rs.getInt("tweetid"));
	      tweet.setText(rs.getString("text"));
	      tweet.setLikes(rs.getInt("likes"));
	      tweet.setRetweets(rs.getInt("retweets"));
	      tweet.setComments(rs.getInt("comments"));
	      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
	      tweet.setParentTweet(rs.getInt("parentTweet"));
	      tweets.add(tweet);
		}
		return tweets;
	}
	
	// Get tweets from a user given start and end
		public List<Tweet> getUserTweetsAnonymouse(Integer uid,Integer start, Integer end) throws Exception {
			String query = "SELECT * FROM Tweets WHERE Tweets.uid = ?";
			PreparedStatement statement = null;
			List<Tweet> l = new ArrayList<Tweet>();
			ManageUser manager = new ManageUser();
			try {
				statement = db.prepareStatement(query);
				statement.setInt(1,uid);
				ResultSet rs = statement.executeQuery();
				while (rs.next()) {
					Tweet tweet = new Tweet();
		       		tweet.setTweetid(rs.getInt("tweetid"));
					tweet.setUid(rs.getInt("uid"));
					tweet.setCreatedAt(rs.getTimestamp("createdAt"));
					tweet.setLikes(rs.getInt("likes"));
					tweet.setComments(rs.getInt("comments"));
					tweet.setRetweets(rs.getInt("retweets"));
					tweet.setText(rs.getString("text"));
					tweet.setIsLiked(tweetIsLiked(tweet.getUid(), tweet.getTweetid()));
					tweet.setIsRetweeted(tweetIsRetweeted(tweet.getUid(), tweet.getTweetid()));
				
				    User usertweet = manager.getUser(tweet.getUid());
				      
				    tweet.setUsername(usertweet.getUsername());
					l.add(tweet);
				}
				rs.close();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			
			query = "SELECT t.uid, r.uid AS ruid, t.tweetid,t.uid,r.createdAt,t.text, t.likes, t.retweets, t.parentTweet, t.comments FROM Tweets t JOIN Retweets r ON r.tweetid=t.tweetid WHERE r.uid = ?;";
			statement = null;
			try {
				statement = db.prepareStatement(query);
				statement.setInt(1,uid);
				ResultSet rs = statement.executeQuery();
				while (rs.next()) {
					Tweet tweet = new Tweet();
		       		tweet.setTweetid(rs.getInt("tweetid"));
					tweet.setUid(rs.getInt("uid"));
					tweet.setCreatedAt(rs.getTimestamp("createdAt"));
					tweet.setLikes(rs.getInt("likes"));
					tweet.setComments(rs.getInt("comments"));
					tweet.setRetweets(rs.getInt("retweets"));
					tweet.setText(rs.getString("text"));
					tweet.setIsLiked(tweetIsLiked(tweet.getUid(), tweet.getTweetid()));
					tweet.setIsRetweeted(tweetIsRetweeted(tweet.getUid(), tweet.getTweetid()));

				    User usertweet = manager.getUser(tweet.getUid());
				    User retweetuser = manager.getUser(rs.getInt("ruid"));
				      
				    tweet.setUsername(usertweet.getUsername());
				    tweet.setRetweetedBy(retweetuser.getUsername());
					l.add(tweet);
				}
				rs.close();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			
			 manager.finalize();
			
			Collections.sort(l, new SortTweetsByTime()); //Sort tweets array.
			
			if(start + end >= l.size()) {
				if(start == l.size() - 1) return l.subList(l.size() - 1, l.size());
				else if(start < l.size() - 1) return l.subList(start, l.size());
				else return Collections.emptyList();
				
			}else {
				return l.subList(start, start + end);
			}
			
		}
	
	// Get tweets from a user given start and end
		public List<Tweet> getUserTweets(Integer uid,Integer start, Integer end, Integer loggedUid) throws Exception {
			String query = "SELECT * FROM Tweets WHERE Tweets.uid = ?;";
			PreparedStatement statement = null;
			List<Tweet> l = new ArrayList<Tweet>();
			ManageUser manager = new ManageUser();
			
			try {
				statement = db.prepareStatement(query);
				statement.setInt(1,uid);
				ResultSet rs = statement.executeQuery();
				while (rs.next()) {
					Tweet tweet = new Tweet();
		       		tweet.setTweetid(rs.getInt("tweetid"));
					tweet.setUid(rs.getInt("uid"));
					tweet.setCreatedAt(rs.getTimestamp("createdAt"));
					tweet.setText(rs.getString("text"));
					tweet.setLikes(rs.getInt("likes"));
					tweet.setComments(rs.getInt("comments"));
					tweet.setRetweets(rs.getInt("retweets"));
					tweet.setParentTweet(rs.getInt("parentTweet"));
					tweet.setIsLiked(tweetIsLiked(loggedUid, tweet.getTweetid()));
					tweet.setIsRetweeted(tweetIsRetweeted(loggedUid, tweet.getTweetid())); //Change variable name
				    User usertweet = manager.getUser(tweet.getUid());
				      
				    tweet.setUsername(usertweet.getUsername());
					l.add(tweet);
				}
				rs.close();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			
			query = "SELECT t.uid, r.uid AS ruid, t.tweetid,t.uid,r.createdAt,t.text, t.likes, t.retweets, t.parentTweet, t.comments FROM Tweets t JOIN Retweets r ON r.tweetid=t.tweetid WHERE r.uid = ?;";
			statement = null;
			try {
				statement = db.prepareStatement(query);
				statement.setInt(1,uid);
				ResultSet rs = statement.executeQuery();
				while (rs.next()) {
					Tweet tweet = new Tweet();
		       		tweet.setTweetid(rs.getInt("tweetid"));
					tweet.setUid(rs.getInt("uid"));
					tweet.setCreatedAt(rs.getTimestamp("createdAt"));
					tweet.setText(rs.getString("text"));
					tweet.setLikes(rs.getInt("likes"));
					tweet.setComments(rs.getInt("comments"));
					tweet.setRetweets(rs.getInt("retweets"));
					tweet.setParentTweet(rs.getInt("parentTweet"));
					
					tweet.setIsLiked(tweetIsLiked(loggedUid, tweet.getTweetid()));
					tweet.setIsRetweeted(tweetIsRetweeted(loggedUid, tweet.getTweetid())); //Change variable name
				
				    User usertweet = manager.getUser(tweet.getUid());
				    User retweetedusertweet = manager.getUser(rs.getInt("ruid"));
				      
				    tweet.setUsername(usertweet.getUsername());
				    tweet.setRetweetedBy(retweetedusertweet.getUsername());
					l.add(tweet);
				}
				rs.close();
				statement.close();
			} catch (SQLException e) {
				e.printStackTrace();
			} 
			
			manager.finalize();
			
			Collections.sort(l, new SortTweetsByTime()); //Sort tweets array.
			
			if(start + end >= l.size()) {
				if(start == l.size() - 1) return l.subList(l.size() - 1, l.size());
				else if(start < l.size() - 1) return l.subList(start, l.size());
				else return Collections.emptyList();
				
			}else {
				return l.subList(start, start + end);
			}
			
		}
	
	public boolean tweetIsLiked(int uid, int tweetid) {
		String query = "SELECT * FROM Likes WHERE uid=? AND tweetid=?";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, uid);
			statement.setInt(2, tweetid);
			ResultSet rs = statement.executeQuery();
			if(rs.next()) return true;
			else return false;
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public void editTweet(int tweetid, String text) {
		String query = "UPDATE Tweets SET text=? WHERE tweetid=?";
		
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setString(1, text);
			statement.setInt(2, tweetid);
			statement.executeUpdate();
			statement.close();
		}catch (SQLException e) {
			e.printStackTrace();
		}
	}
		
	public void deleteTweet(int tweetid) throws Exception{
		
		String query = "SELECT uid FROM Tweets WHERE tweetid = ?";

		PreparedStatement statement = null;
		Integer uid = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, tweetid);
			ResultSet rs = statement.executeQuery();
			if(rs.next()) uid = rs.getInt("uid");
		}catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		String query4 = "DELETE FROM Likes WHERE tweetid = ?";
		PreparedStatement statement4 = null; //treu like a la taula de likes
		
		try {
			statement4 = db.prepareStatement(query4);
			statement4.setInt(1, tweetid);
			statement4.executeUpdate();
			statement4.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		String query5 = "DELETE FROM Retweets WHERE tweetid = ?";
		PreparedStatement statement5 = null; //treu like a la taula de likes
		
		try {
			statement5 = db.prepareStatement(query5);
			statement5.setInt(1, tweetid);
			statement5.executeUpdate();
			statement5.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		String query2 = "DELETE FROM Tweets WHERE tweetid = ?";

		PreparedStatement statement2 = null;
		try {
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		String query3 = "UPDATE Users SET tweets = tweets - 1 WHERE uid = ?";
		PreparedStatement statement3 = null; //treure el tweet a la pagina del user q ha retuitat

		try {
			statement3 = db.prepareStatement(query3);
			statement3.setInt(1, uid);
			statement3.executeUpdate();
			statement3.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
			
	}
	
	public void addComent(Tweet commentTweet) throws Exception{
		
		//Afegim el comentari com a tweet
		this.insertTweet(commentTweet);

		//Trobem el tweet pare i incrementem el contador de comentaris
		String query = "UPDATE Tweets SET comments = comments + 1 WHERE tweetid = ?";
		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, commentTweet.getParentTweet());
			statement.executeUpdate();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	}

	public void deleteComent(Tweet commentTweet) throws Exception{
		
		//Eliminem el comentari com a tweet
		this.deleteTweet(commentTweet.getTweetid());

		//Trobem el tweet pare i restem el contador de comentaris
		String query = "UPDATE Tweets SET comments = comments - 1 WHERE tweetid = ?";
		PreparedStatement statement = null;
		try {
		statement = db.prepareStatement(query);
		statement.setInt(1, commentTweet.getParentTweet());
		statement.executeUpdate();
		statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
	}	
 

	public boolean dislikeTweet(Integer tweetid, Integer uid) throws Exception{
	
		String query1 = "DELETE FROM Likes WHERE tweetid = ? and uid = ?";
		PreparedStatement statement1 = null; //afegeix like a la taula de likes
		int rows_modified = 0;
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, tweetid);
			statement1.setInt(2, uid);
			rows_modified = statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			System.out.println("pROBLEM DELETING");
			e.printStackTrace();
			return false;
		}
		
		if(rows_modified == 0) return false;
		
		String query2 = "UPDATE Tweets SET likes = likes - 1 WHERE tweetid = ?";
		PreparedStatement statement2 = null; //decrementem comptador de likes a liked tweet 
		
		try {
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	


	public boolean likeTweet(Integer tweetid, Integer uid) throws Exception{
	
		String query1 = "INSERT INTO Likes (uid,tweetid) VALUES (?,?)";
		PreparedStatement statement1 = null; //afegeix like a la taula de likes
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false; //Si el usuari no ha pogut donarli like que no intenti sumarli un like al tweet.
		}
		
		String query2 = "UPDATE Tweets SET likes = likes + 1 WHERE tweetid = ?";
		PreparedStatement statement2 = null; //inrementem comptador de likes a liked tweet 
		
		try {
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	

	public boolean retweetTweet(Integer tweetid, Integer uid) throws Exception{
		
		//Afegeix retweet a la taula de retweets.
		String query1 = "INSERT INTO Retweets (uid,tweetid, createdAt) VALUES (?,?,?)";
		PreparedStatement statement1 = null;
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
			statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		//Incrementem comptador de retweets al retweeted tweet 
		String query2 = "UPDATE Tweets SET retweets = retweets + 1 WHERE tweetid = ?";
		PreparedStatement statement2 = null; 
		
		try {			
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		//Afegir el tweet a la pagina del user que ha retuitat
		String query3 = "UPDATE Users SET tweets = tweets + 1 WHERE uid = ?";
		PreparedStatement statement3 = null; 

		try {
			statement3 = db.prepareStatement(query3);
			statement3.setInt(1, uid);
			statement3.executeUpdate();
			statement3.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
		
	}
	
	public boolean unretweetTweet(Integer tweetid, Integer uid) throws Exception{
		
		//Eliminem retweet a la taula de retweets
		String query1 = "DELETE FROM Retweets WHERE tweetid = ? and uid = ?";
		PreparedStatement statement1 = null; 
		int rows_modified = 0;
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, tweetid);
			statement1.setInt(2, uid);
			rows_modified = statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		if(rows_modified == 0) return false;
		
		//Decrementem comptador de retweets al retweeted tweet 
		String query2 = "UPDATE Tweets SET retweets = retweets - 1 WHERE tweetid = ?";
		PreparedStatement statement2 = null;
		
		try {			
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		//Treure el tweet a la pagina del user que ha retuitat
		String query3 = "UPDATE Users SET tweets = tweets - 1 WHERE uid = ?";
		PreparedStatement statement3 = null;

		try {
			statement3 = db.prepareStatement(query3);
			statement3.setInt(1, uid);
			statement3.executeUpdate();
			statement3.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	public boolean tweetIsRetweeted(int uid, int tweetid) {
		String query = "SELECT * FROM Retweets WHERE uid=? AND tweetid=?";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, uid);
			statement.setInt(2, tweetid);
			ResultSet rs = statement.executeQuery();
			if(rs.next()) return true;
			else return false;
		}catch (SQLException e) {
			e.printStackTrace();
		}
		
		return false;
	}
	
	public List<Tweet> getAllTweetsAnonymouse(int start, int end) throws Exception {

		List<Tweet> tweets = new ArrayList<Tweet>();
		ManageUser manager = new ManageUser();
		
		String query = "SELECT * FROM Tweets ORDER BY createdAt DESC LIMIT ?,? ;";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, start);
			statement.setInt(2, end);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("uid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(false);
		      tweet.setIsRetweeted(false);
		      
		      User usertweet = manager.getUser(tweet.getUid());
		      
		      tweet.setUsername(usertweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		

		query = "SELECT r.uid AS ruid, r.createdAt, t.tweetid, t.text, t.likes, t.retweets, t.comments, t.parentTweet FROM Retweets r JOIN Tweets t ON r.tweetid=t.tweetid LIMIT ?,?;";

		statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, start);
			statement.setInt(2, end);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("ruid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(false);
		      tweet.setIsRetweeted(false);
		      
		      User usertweet = manager.getUser(tweet.getUid());
		      User userretweet = manager.getUser(rs.getInt("ruid"));
		      
		      
		      tweet.setUsername(usertweet.getUsername());
		      tweet.setRetweetedBy(userretweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		manager.finalize();
		
		Collections.sort(tweets, new SortTweetsByTime()); //Sort tweets array.
		
		return tweets;
		
	}
	
	public List<Tweet> getAllTweets(int uid,int start, int end) throws Exception {

		List<Tweet> tweets = new ArrayList<Tweet>();
		ManageUser manager = new ManageUser();
		
		String query = "SELECT * FROM Tweets ORDER BY createdAt";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			//statement.setInt(1, start);
			//statement.setInt(2, end);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("uid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(this.tweetIsLiked(uid, tweet.getTweetid()));
		      tweet.setIsRetweeted(this.tweetIsRetweeted(uid, tweet.getTweetid()));
		      
		      User usertweet = manager.getUser(tweet.getUid());
		   
		      tweet.setUsername(usertweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		query = "SELECT r.uid AS ruid, t.uid, r.createdAt, t.tweetid, t.text, t.likes, t.retweets, t.comments, t.parentTweet FROM Retweets r JOIN Tweets t ON r.tweetid=t.tweetid";

		statement = null;
		try {
			statement = db.prepareStatement(query);
			//statement.setInt(1, start);
			//statement.setInt(2, end);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("uid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(this.tweetIsLiked(uid, tweet.getTweetid()));
		      tweet.setIsRetweeted(this.tweetIsRetweeted(uid, tweet.getTweetid()));
		      
		      User usertweet = manager.getUser(tweet.getUid());
		      User userretweet = manager.getUser(rs.getInt("ruid"));
		   
		      tweet.setUsername(usertweet.getUsername());
		      tweet.setRetweetedBy(userretweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		manager.finalize();
		
		Collections.sort(tweets, new SortTweetsByTime()); //Sort tweets array.
		
		if(start + end >= tweets.size()) {
			if(start == tweets.size() - 1) return tweets.subList(tweets.size() - 1, tweets.size());
			else if(start < tweets.size() - 1) return tweets.subList(start, tweets.size());
			else return Collections.emptyList();
			
		}else {
			return tweets.subList(start, start + end);
		}
		
	}
	
	
	public List<Tweet> getAllTweetsFollowing(int uid,int start, int end) throws Exception {

		List<Tweet> tweets = new ArrayList<Tweet>();
		ManageUser manager = new ManageUser(); 
		
		String query = "SELECT * FROM ((SELECT uid2 AS uid FROM Follows f WHERE f.uid1=?) UNION (SELECT ?)) AS fIDs INNER JOIN Tweets t ON t.uid=fIDs.uid";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, uid);
			statement.setInt(2, uid);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("uid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(this.tweetIsLiked(uid, tweet.getTweetid()));
		      tweet.setIsRetweeted(this.tweetIsRetweeted(uid, tweet.getTweetid()));
		      
		      User usertweet = manager.getUser(tweet.getUid());
		      
		      tweet.setUsername(usertweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		query = "SELECT r.uid AS ruid, t.uid, t.tweetid, r.createdAt, t.text, t.likes, t.retweets, t.comments, t.parentTweet FROM ((SELECT uid2 AS uid FROM Follows f WHERE f.uid1=?) UNION (SELECT ?)) AS fIDs JOIN Retweets r ON r.uid=fIDs.uid JOIN Tweets t ON t.tweetid=r.tweetid";

		statement = null;
		try {
			statement = db.prepareStatement(query);
			statement.setInt(1, uid);
			statement.setInt(2, uid);
			ResultSet rs = statement.executeQuery();

			while (rs.next()) {
		      Tweet tweet = new Tweet();
		      
		      /*Omplim les dades del tweet*/
		      tweet.setUid(rs.getInt("uid"));
		      tweet.setTweetid(rs.getInt("tweetid"));
		      tweet.setText(rs.getString("text"));
		      tweet.setLikes(rs.getInt("likes"));
		      tweet.setRetweets(rs.getInt("retweets"));
		      tweet.setComments(rs.getInt("comments"));
		      tweet.setCreatedAt(rs.getTimestamp("createdAt"));
		      tweet.setParentTweet(rs.getInt("parentTweet"));
		      tweet.setIsLiked(this.tweetIsLiked(uid, tweet.getTweetid()));
		      tweet.setIsRetweeted(this.tweetIsRetweeted(uid, tweet.getTweetid()));
		      
		      User usertweet = manager.getUser(tweet.getUid());
		      User userretweettweet = manager.getUser(rs.getInt("ruid"));
		      
		      tweet.setUsername(usertweet.getUsername());
		      tweet.setRetweetedBy(userretweettweet.getUsername());
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		manager.finalize();
		
		Collections.sort(tweets, new SortTweetsByTime()); //Sort tweets array.
		
		if(start + end >= tweets.size()) {
			if(start == tweets.size() - 1) return tweets.subList(tweets.size() - 1, tweets.size());
			else if(start < tweets.size() - 1) return tweets.subList(start, tweets.size());
			else return Collections.emptyList();
			
		}else {
			return tweets.subList(start, start + end);
		}
		
	}

}
