package service;

import dao.cancelDAO;
import dao.ticketDAO;
import dao.transactionDAO;
import dao.userDAO;
import dto.ticket;

public class CancelService {

	public void cancelProcess(int ticket_id, String user_id) {
		ticketDAO tiD = new ticketDAO();
		cancelDAO caD = new cancelDAO();
		userDAO usD = new userDAO();
		transactionDAO trans = new transactionDAO();

		trans.startTrans();
		ticket tic = tiD.deleteTicket(ticket_id);
		caD.addCancel(user_id, tic);
		usD.userRefund(user_id, tic.getPayment());
		
		trans.commit();
	}
}
