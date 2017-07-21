<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Singlepageapp extends CI_Controller {

	public function __construct()
    {
        parent::__construct();
        $this->load->model('channels', '', TRUE);
        $this->load->model('programs', '', TRUE);
        $channelsList = $this->input->cookie('channelselection');
        $this->channelselection = $this->getUserSelection($channelsList);
        $this->config->load('gedeho');
    }

    public function index(){
        $results = $this->programs->getCurrent($this->channelselection);
        $data['programs'] = $results;
        $data['title'] = "Programmes TV du ".date("d-m-Y");
        $data['channels'] = $this->channels->getChannels();
        $this->parser->parse("programmes/singlepage.tpl", $data);   
    }

    public function refresh(){
        $selection = $this->input->get('channels');
        $programs = $this->programs->getCurrent($this->channelselection);
        $this->parseResponse($programs);
    }

    public function getEveningPrograms(){
        $creneau = $this->input->get('creneau');
        $startA = $this->config->item('eveningStart'.$creneau);
        $startB = $this->config->item('eveningEnd'.$creneau);
        $programs = $this->programs->getRange($startA, $startB, $this->channelselection);
        $this->parseResponse($programs);
    }

    public function getSoonFinished(){
        $finishIn = $this->input->get('a');
        $programs = $this->programs->getSoonFinished($finishIn);
        $this->parseResponse($programs);
    }

    public function getSoonStarted(){
        $startIn = $this->input->get('a');
        $programs = $this->programs->getSoonStarted($startIn);
        $this->parseResponse($programs);        
    }

    private function getUserSelection($channelsList){               
        if($channelsList && count($channelsList)> 0){
            $channelselection = json_decode($this->input->cookie('channelselection'));
        }
        else{
            $channelselection = array("2", "3", "13", "5", "6", "1");
        }        
        return $channelselection;
    }

    private function parseResponse($datas){
        $this->output
                ->set_content_type('application/json')
                ->set_output(json_encode($datas));
    }

    public function updateFeed(){
        $this->load->library('feedupdater');
        $this->feedupdater->updateFeed();
        redirect('programmestv/getCurrent');
    }
}