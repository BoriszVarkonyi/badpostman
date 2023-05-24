#!/bin/zsh
#CLI SCRIPT TO TEST API ENDPOINTS

echo "\e[1;31m
BBBBB     AAA   DDDDD   PPPPPP   OOOOO   SSSSS  TTTTTTT MM    MM   AAA   NN   NN
BB   B   AAAAA  DD  DD  PP   PP OO   OO SS        TTT   MMM  MMM  AAAAA  NNN  NN
BBBBBB  AA   AA DD   DD PPPPPP  OO   OO  SSSSS    TTT   MM MM MM AA   AA NN N NN
BB   BB AAAAAAA DD   DD PP      OO   OO      SS   TTT   MM    MM AAAAAAA NN  NNN
BBBBBB  AA   AA DDDDDD  PP       OOOO0   SSSSS    TTT   MM    MM AA   AA NN   NN
"
echo "\e[4;35mMade by: Borisz Varkonyi\n\n"
echo "\e[0;36mEnter the function's number that you want to use"
echo "1: Make new API call"
echo "2: Set token endpoint"
echo "3: Add endpoint"
read func_num
token_query()
{
	curl -X POST https://api.dartagnan.cc/api/token/ -H "Content-Type: application/json" -d '{"username":"root","password":"d4RTagnan"}' -o token.txt
}

if [[ $func_num == 1 ]]; then
	echo "\n\nChoose method"
	echo "1: POST"
	echo "2: GET"
	echo "3: PUT"
	echo "4: DELETE"
	read METHOD_NUM

	#-----------------------
	#READ API ENDPOINT FILES
	
	read_endpoints ()
	{
		counter=0
		while IFS= read -r line
			do
				((counter=counter+1))
			echo "$counter"
			echo "$line"
		done < urls.txt	
	}

	#-----------------------
	
	#Add calls
	add_endpoints ()
	{
		
	}

	get()
	{
		echo "\n\nSelect URL:"
		read_endpoints
		read URL_INPUT

		counter=0
		while IFS= read -r line
			do
				((counter=counter+1))
				if [[ $counter -eq $URL_INPUT ]]; then
					NEWLINE=$line
					echo "$counter"
					echo "$URL_INPUT"
				fi
		done < urls.txt		
		echo "$NEWLINE"
		token_query
		line=$(head -n 1 token.txt)
		access_token="${line:272:247}"
		curl -X GET $NEWLINE -H "Content-Type: application/json" -H "Authorization: Bearer $access_token" -o get_response.json
		clear
		/home/linuxbrew/.linuxbrew/Cellar/jless/0.8.0/bin/jless get_response.json
	}

	#-----------------------
	case "$METHOD_NUM" in
		1) echo "This function is not ready yet"
		;;
	        2) get
		;;
	        3) echo "This function is not ready yet"
		;;
	        4) echo "This function is not ready yet"
		;;
		*) echo "Wrong button pressed"
		;;
	esac
	
fi


if [[ $func_num == 2 ]]; then
	echo "Enter the API endpoint:"
	read endpoint_link
	echo "Enter validation information"
	read endpoint_valid
fi


if [[ $func_num == 3 ]]; then
	echo "Add endpoint URL"
	read URL
	echo "$URL" >> urls.txt
fi

echo "$endpoint_link" > endpoint_link.txt
echo "$endpoint_valid" > endpoint_valid.txt

echo "$endpoint_link"
