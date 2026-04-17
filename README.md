# jayson - JSON Output parser.
----
## Usage
<img width="791" height="417" alt="image" src="https://github.com/user-attachments/assets/53c01b1b-1a61-4805-86e9-927709e7c57c" />
<img width="1033" height="267" alt="image" src="https://github.com/user-attachments/assets/e635e769-3152-46fb-a0b5-b8451da0350d" />
<img width="452" height="156" alt="image" src="https://github.com/user-attachments/assets/ca0d56bf-9408-409f-a001-685ecabd6426" />



# Commands
- ```jayson.sh -f 20260405155710_users.json -p 'name' | sort | uniq | tee wordlistName.txt```
- ```jayson.sh -f 20260405155710_users.json -p name,lastlogon,pwdlastset | tee output.txt```
- _Can also put results on an output file using -o file.txt_
