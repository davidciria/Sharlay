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
 * Servlet implementation class LikeTweet
 * 
 * Servlet per donar like a un tweet.
 * 
 */
@WebServlet("/LikeTweet")
public class LikeTweet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LikeTweet() {
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
			boolean result = false;
			if(!tweetManager.tweetIsLiked(uid, tweet.getTweetid())) result = tweetManager.likeTweet(tweet.getTweetid(), uid);
			/*Verificar si hi ha hagut algun error.*/
			if(result) response.setStatus(HttpServletResponse.SC_ACCEPTED);
			else{
				response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
			}
		}catch(Throwable e) {
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
