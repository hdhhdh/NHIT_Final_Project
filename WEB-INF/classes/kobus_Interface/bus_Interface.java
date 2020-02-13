package kobus_Interface;

import java.util.ArrayList;

import dto.bus;

public interface bus_Interface {
	public ArrayList<bus> selectBusTime(int rid);
	public void addBus();
	public void countBus();
	public void selectManageBus();
}
