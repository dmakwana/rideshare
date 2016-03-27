import grequests
import json
import datetime

headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}

rides = []

rides_url = "http://rideshare.supreet.ca/ride/save/"

locations = ["University of Waterloo", 
		     "Square One", 
		     "Yorkdale Mall", 
		     "Union Station", 
		     "York University", 
		     "Western University", 
		     "McMaster University", 
		     "Queens University", 
		     "Carleton University"]

k = 0
for i in range(30):
	for j in range(5):
		ride = {}
		ride['ride_id'] = -1
		ride['facebook_id'] = str(k)
		ride['start_location'] = locations[0]
		ride['end_location'] = locations[j+1]
		dateStr = "Apr " + str(i+1).zfill(2) + ", 2016"
		timeStr = str(j+1).zfill(2)+":00 PM"
		ride['date'] = dateStr
		ride['time'] = timeStr
		if j < 1:
			ride['spots'] = 1
			ride['active'] = False
		else:
			ride['spots'] = j
			ride['active'] = True
		ride_dict = {}
		ride_dict['ride_dict'] = ride
		rides.append(ride_dict)
		k += 1

print rides


async_list = []
for ride in rides:
	action_item = grequests.post(rides_url, data=json.dumps(ride), headers=headers)
	async_list.append(action_item)

grequests.map(async_list)
