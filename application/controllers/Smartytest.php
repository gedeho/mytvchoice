<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

/**
 * CI Smarty
 *
 * Smarty templating for Codeigniter
 *
 * @package   CI Smarty
 * @author    Dwayne Charrington
 * @copyright 2015 Dwayne Charrington and Github contributors
 * @link      http://ilikekillnerds.com
 * @license   MIT
 * @version   3.0
 */

class Smartytest extends CI_Controller {

    public function index()
    {
        $data['title'] = "Accueil";
        $data['view']  = "home.tpl";

        $this->parser->parse("master.tpl", $data);
        
    }

    

    


    

    



}
