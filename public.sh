#!/bin/bash
get_node_url(){

		NODE_URL='https://www.sxsay.com';

}

if [ ! $NODE_URL ];then
	echo '正在选择下载节点...';
	get_node_url
fi
