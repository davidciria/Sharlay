package managers;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


import utils.DAO;
import models.Tweet;


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
			//db.disconnectBD();
		} catch (Throwable e) {
			e.printStackTrace();
		}
	}
	
	public void insertTweet(Tweet tweet) throws Exception{
		
		String query = "INSERT INTO Tweets (uid,text,likes,retweets,comments,createdAt,parentTweet) VALUES (?,?,?,?,?,?,?)";
		System.out.println(tweet.getUid());
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
	public List<Tweet> getTweets(Integer tweetid) throws Exception {

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
	public List<Tweet> getUserTweets(String uid,Integer start, Integer end) {
		String query = "SELECT Tweets.tweetid,Tweets.uid,Tweets.createdAt,Tweets.text FROM Tweets WHERE Tweets.uid = ? ORDER BY Tweets.createdAt DESC LIMIT ?,? ;";
		PreparedStatement statement = null;
		List<Tweet> l = new ArrayList<Tweet>();
		try {
			statement = db.prepareStatement(query);
			statement.setString(1,uid);
			statement.setInt(2,start);
			statement.setInt(3,end);
			ResultSet rs = statement.executeQuery();
			while (rs.next()) {
				Tweet tweet = new Tweet();
	       		tweet.setTweetid(rs.getInt("tweetid"));
				tweet.setUid(rs.getInt("uid"));
				tweet.setCreatedAt(rs.getTimestamp("createdAt"));
				tweet.setText(rs.getString("text"));
				l.add(tweet);
			}
			rs.close();
			statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		return  l;
	}
	
	
	public void deleteTweet(int tweetid) throws Exception{
		
		String query = "DELETE FROM Tweets WHERE tweetid = ?";

		PreparedStatement statement = null;
		try {
		statement = db.prepareStatement(query);
		statement.setInt(1, tweetid);
		statement.executeUpdate();
		statement.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
		String query2 = "SELECT uid FROM Tweets WHERE tweetid = ?";

		PreparedStatement statement2 = null;
		Integer uid = null;
		try {
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			ResultSet rs = statement2.executeQuery();
			uid = rs.getInt("uid");
		}catch (SQLException e) {
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
 

	public void dislikeTweet(Integer tweetid, Integer uid) throws Exception{
	
		String query1 = "DELETE FROM Likes WHERE tweetid = ? and uid = ?";
		String query2 = "UPDATE Tweets SET likes = likes - 1 WHERE tweetid = ?";

		PreparedStatement statement1 = null; //afegeix like a la taula de likes
		PreparedStatement statement2 = null; //decrementem comptador de likes a liked tweet 
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.executeUpdate();
			statement1.close();
			
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	}


	public void likeTweet(Integer tweetid, Integer uid) throws Exception{
	
		String query1 = "INSERT INTO Likes (uid,tweetid) VALUES (?,?)";
		String query2 = "UPDATE Tweets SET likes = likes + 1 WHERE tweetid = ?";

		PreparedStatement statement1 = null; //afegeix like a la taula de likes
		PreparedStatement statement2 = null; //inrementem comptador de likes a liked tweet 
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.executeUpdate();
			statement1.close();
			
			statement2 = db.prepareStatement(query2);
			statement2.setInt(1, tweetid);
			statement2.executeUpdate();
			statement2.close();

		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
	}
	
	

	public void retweetTweet(Integer tweetid, Integer uid) throws Exception{
		
		//Afegeix retweet a la taula de retweets.
		String query1 = "INSERT INTO Retweets (uid,tweetid) VALUES (?,?)";
		PreparedStatement statement1 = null;
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
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
			return;
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
			return;
		}
		
	}
	
	public void unretweetTweet(Integer tweetid, Integer uid) throws Exception{
		
		//Eliminem retweet a la taula de retweets
		String query1 = "DELETE FROM Retweets WHERE tweetid = ? and uid = ?";
		PreparedStatement statement1 = null; 
		
		try {
			statement1 = db.prepareStatement(query1);
			statement1.setInt(1, uid);
			statement1.setInt(2, tweetid);
			statement1.executeUpdate();
			statement1.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return;
		}
		
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
			return;
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
			return;
		}
	}
	

	public List<Tweet> getAllTweets() throws Exception {

		List<Tweet> tweets = new ArrayList<Tweet>();
		
		String query = "SELECT * FROM Tweets ORDER BY createdAt DESC";

		PreparedStatement statement = null;
		try {
			statement = db.prepareStatement(query);
			
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
		      
		      /*Afegim el tweet a la llista de tweets*/
		      tweets.add(tweet);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return tweets;
		
	}

}
