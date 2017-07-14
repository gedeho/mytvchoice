<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Channels extends CI_Model {

        public function updateChannels($channelId, $channelIcon, $channelName){
        	$data = array(
		        'channelId' => $channelId,
		        'name'  => $channelName,
		        'logo'  => $channelIcon
			);
			$this->db->replace('channels', $data);
    	}

    	public function getChannels(){
            $this->db->order_by('channelId ASC');
            return $this->db->get('channels')->result();
    	}

       
}