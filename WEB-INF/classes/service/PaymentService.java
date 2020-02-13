package service;

import dao.ticketDAO;
import dao.transactionDAO;
import dao.userDAO;

public class PaymentService {
	ticketDAO tic;
	userDAO ur;
	transactionDAO trans;
	
	
	public PaymentService() {
		tic = new ticketDAO();
		ur = new userDAO();
		trans = new transactionDAO();
	}
	
	public String ticketingProcess(int bus_id, String[] seat_num, String user_id, String[] prices, int payment) {
		trans.startTrans();
		
		String result = "";
		if(tic.validTicket(bus_id, seat_num)) {
			tic.addTicket(bus_id, seat_num, user_id, prices);
			ur.userPayment(user_id, payment);
			result = "Success";
			trans.commit();
		}
		else {
			result = "Fail... Please try agin.";
		}
		
		return result;
	}
}
