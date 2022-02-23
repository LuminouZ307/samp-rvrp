stock IsBusVehicle(vehicleid)
{
	forex(i, sizeof(BusVehicle))
	{
		if(vehicleid == BusVehicle[i]) return 1;
	}
	return 0;
}