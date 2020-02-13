package kobus_Interface;

import java.util.ArrayList;

import dto.myTickets;
import dto.ticket;

public interface ticket_Interface {
	public ArrayList<ticket> selectTicket(int bus_id);
	public void addTicket(int bus_id, String[] seat_num, String user_id, String[] prices);
	public ArrayList<myTickets> selectUserTicket(String user_id);
	public ticket deleteTicket(int ticket_id);
	public void countTicket();
}
