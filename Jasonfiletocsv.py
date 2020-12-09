"""
Created on Sat Dec  5 2020

@author: Jinzhe Zhang
"""

import pandas as pd
json_data = pd.read_json('C:/Users/zheny/Desktop/yelp_academic_dataset_business.json',lines=True)
json_data.head()
bool = json_data['categories'].str.contains('Janpanese')
filter_data = json_data[bool]
filter_data.to_csv('C:/Users/zheny/Desktop/yelp_academic_dataset_business.csv',index=False)

json_data = pd.read_json('C:/Users/zheny/Desktop/yelp_academic_dataset_tip.json',lines=True)
json_data.head()
filter_data.to_csv('C:/Users/zheny/Desktop/yelp_academic_dataset_tip.csv',index=False)

json_data = pd.read_json('C:/Users/zheny/Desktop/yelp_academic_dataset_review.json',lines=True)
json_data.head()
filter_data.to_csv('C:/Users/zheny/Desktop/yelp_academic_dataset_review.csv',index=False)

json_data = pd.read_json('C:/Users/zheny/Desktop/yelp_academic_dataset_review.json',lines=True)
json_data.head()
filter_data.to_csv('C:/Users/zheny/Desktop/yelp_academic_dataset_review.csv',index=False)

json_data = pd.read_json('C:/Users/zheny/Desktop/yelp_academic_dataset_checkin.json',lines=True)
filter_data.to_csv('C:/Users/zheny/Desktop/yelp_academic_dataset_checkin.csv',index=False)
