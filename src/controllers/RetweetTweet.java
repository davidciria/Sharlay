package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageTweet;
import models.Tweet;

/**
 * Servlet implementation class RetweetTweet
 * 
 * Servlet per fer un retweet dun tweet.
 * 
 */
@WebServlet("/RetweetTweet")
public class RetweetTweet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RetweetTweet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		HttpSession session = request.getSession(false);
		int uid = (int)session.getAttribute("uid");
		Tweet tweet = new Tweet();
		ManageTweet tweetManager = new ManageTweet();
		
		try {
			BeanUtils.populate(tweet, request.getParameterMap());
			/*Si no esta retweetejat per l'usuari fem retweet*/
			boolean result = false;
			if(!tweetManager.tweetIsRetweeted(uid, tweet.getTweetid())) result = tweetManager.retweetTweet(tweet.getTweetid(), uid); 
			if(result) response.setStatus(HttpServletResponse.SC_ACCEPTED);
			else{
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		tweetManager.finalize();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
