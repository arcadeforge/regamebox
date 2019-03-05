
#pikeyd165 -k
#cp /etc/pikeyd165.conf /etc/pikeyd165_tmp.conf
#cp /etc/pikeyd165_check.conf /etc/pikeyd165.conf
#pikeyd165 -smi -ndb -d
python3 check_pi2jamma.py
#pikeyd165 -k
#killall pikeyd165
#cp /etc/pikeyd165_tmp.conf /etc/pikeyd165.conf
