package controllers;

import java.io.IOException;
import java.sql.Timestamp;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageTweet;
import models.Tweet;

/**
 * Servlet implementation class AddTweetFromUser
 */
@WebServlet("/AddTweetFromUser")
public class AddTweetFromUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTweetFromUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tweet tweet = new Tweet();
		
		try {
			BeanUtils.populate(tweet, request.getParameterMap());
			ManageTweet tweetManager = new ManageTweet();
			//Create tweet.
			Tweet new_tweet = new Tweet();
			tweet.setText(tweet.getText());
			tweet.setCreatedAt(new Timestamp(System.currentTimeMillis()));
			tweet.setUid(tweet.getUid());
			tweet.setRetweets(0);
			tweet.setComments(0);
			tweet.setLikes(0);
			tweet.setParentTweet(null);
			/**/
			tweetManager.insertTweet(new_tweet);
			tweetManager.finalize();

		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}