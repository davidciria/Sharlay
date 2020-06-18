package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageTweet;
import models.Tweet;
/**
 * Servlet implementation class DelTweetFromUser
 */
@WebServlet("/DelTweetFromUser")
public class DelTweetFromUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelTweetFromUser() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tweet tweet = new Tweet();
		
		try {
			BeanUtils.populate(tweet, request.getParameterMap());
			ManageTweet tweetManager = new ManageTweet();
			tweetManager.deleteTweet(tweet.getTweetid());
			tweetManager.finalize();
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
