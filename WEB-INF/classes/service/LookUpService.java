package service;

import java.util.ArrayList;

import dao.cancelDAO;
import dao.ticketDAO;
import dto.myCancel;
import dto.myTickets;

public class LookUpService {
	
	public ArrayList<myTickets> selectUserTicket(String user_id) {
		ticketDAO 	tic = new ticketDAO();
		ArrayList<myTickets> arr_tic = tic.selectUserTicket(user_id);
		
		return arr_tic;
	}

	public ArrayList<myCancel> selectUserCancel(String user_id) {
		cancelDAO can = new cancelDAO();
		ArrayList<myCancel> arr_can = can.selectUserCancel(user_id);
		
		return arr_can;
	}

}
