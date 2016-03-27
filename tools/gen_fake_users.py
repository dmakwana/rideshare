import grequests
import json

# def do_something(response):
#     print response.url

headers = {'Content-type': 'application/json', 'Accept': 'text/plain'}

users = []

users_url = "http://rideshare.supreet.ca/user/login/"

fb_id = "aaaaaa"
access_token = "bbbbbb"

img_urls = ["http://rocketdock.com/images/screenshots/nicolac.png",
			"https://pbs.twimg.com/profile_images/3651897558/35aa6290d2f217731f5b5a0c8f0cd574.jpeg",
			"https://pbs.twimg.com/profile_images/589081644989943810/TCsr9vN6.jpg",
			"https://pbs.twimg.com/profile_images/3740015736/ff9079984d86982030d3df176c581adc.jpeg",
			"http://www.whatsonyourwall.com/music-movies-15/icon-president-obama-size-colour-blue-20303-40781_medium.jpg"]

names = ["Niicholas Cage",
		 "Nick Cage",
		 "John Doe",
		 "Random Person",
		 "Barrack Obama"]

phone_num = "1234567890"
email = "hello@hello.com"
car_name = "Honda Accord"

k = 0
for i in range(30):
	for j in range(5):
		user_dict = {}
		user_dict['facebook_id'] = str(k)
		user_dict['access_token'] = str(k)
		user_dict['full_name'] = (names[j]+ " "+str(i))
		user_dict['profile_picture'] = img_urls[j]
		user_dict['phone_number'] = phone_num
		user_dict['email'] = email
		user_dict['car_name'] = car_name
		login_dict = {}
		login_dict['login_dict'] = user_dict
		users.append(login_dict)
		k += 1

async_list = []
for user in users:
	action_item = grequests.post(users_url, data=json.dumps(user), headers=headers)
	async_list.append(action_item)

grequests.map(async_list)

