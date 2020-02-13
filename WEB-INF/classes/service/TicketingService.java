package service;

import java.util.ArrayList;

import dao.busDAO;
import dao.ticketDAO;
import dto.bus;
import dto.route;
import dto.ticket;

public class TicketingService {

	ticketDAO ticDAO;
	ArrayList<ticket> tic;

	public TicketingService() {
		
	}
	
	public TicketingService(int bus_id) {
		ticDAO = new ticketDAO();
		tic = ticDAO.selectTicket(bus_id);
	}
	
	public ArrayList<bus> routeProcess(int r_id, String date) {

		ArrayList<bus> busArray = new ArrayList<bus>();
		busDAO bus = new busDAO();

		busArray = bus.selectBusTime(r_id);
		return busArray;
		/*for(int i = 0; i<busArray.size(); i++)
		{
			System.out.println(busArray.get(i).getBus_id());
			System.out.println(busArray.get(i).getBus_stat());
			System.out.println(busArray.get(i).getBus_start());
			System.out.println(busArray.get(i).getRoute_id());
			System.out.println(busArray.get(i).getBus_co());
			
		}*/
		
	}
	

	public boolean viewSeat(int seat) {
		for(int i=0; i<tic.size(); i++){
			if(seat == tic.get(i).getSeat_num())
				return true;
		}
		return false;
	}
	
	
}
