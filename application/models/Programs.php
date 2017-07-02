<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Programs extends CI_Model {
    public $newest;

    // récupérer la date du programme le plus éloigné dans le temps
    public function __construct(){
        parent::__construct();
        date_default_timezone_set('Europe/Paris');
        $this->newest = strtotime($this->getLastNewerProgram());                
    }

    public function addPrograms($datas){    	
        $programDate = strtotime($datas['start']);
        if($programDate > $this->newest) {
            $this->db->insert('programs', $datas);
        };
	}

    public function clearOldPrograms(){
        // effacer tous les programmes < à la date du jour
    }

	public function getCurrent(){
        $this->db->where("start <= NOW()", NULL, FALSE);
        $this->db->where("end >= NOW()", NULL, FALSE);
        $this->db->join('channels', 'channels.channelId = programs.channelId');
        $this->db->order_by('programs.channelId ASC, start ASC');
        return $this->db->get('programs')->result();
	}

    public function getSoonFinished($finishIn){
        $this->db->where("end >= NOW()", NULL, FALSE);
        $this->db->where("end <= DATE_ADD(NOW(), INTERVAL ".$finishIn." MINUTE)", NULL, FALSE);
        $this->db->join('channels', 'channels.channelId = programs.channelId');
        $this->db->order_by('programs.channelId ASC, start ASC');
        return $this->db->get('programs')->result();
    }

    public function getSoonStarted($startIn){
        $this->db->where("start >= NOW()", NULL, FALSE);
        $this->db->where("start <= DATE_ADD(NOW(), INTERVAL ".$startIn." MINUTE)", NULL, FALSE);
        $this->db->join('channels', 'channels.channelId = programs.channelId');
        $this->db->order_by('programs.channelId ASC, start ASC');
        return $this->db->get('programs')->result();
    }

    public function getRange($startA, $startB){
        $FormatedStartA = date('Y-m-d H:i:s', strtotime($startA));
        $FormatedStartB = date('Y-m-d H:i:s', strtotime($startB));
        $this->db->where('start >=', $FormatedStartA);
        $this->db->where('start <=', $FormatedStartB);
        $this->db->where('length >', '30');
        $this->db->join('channels', 'channels.channelId = programs.channelId');
        $this->db->order_by('programs.channelId ASC, start ASC');
        return $this->db->get('programs')->result();
    }

    public function getLastNewerProgram(){
        $this->db->select_max('end');
        $query = $this->db->get('programs');
        return $query->row()->end;
    }
}