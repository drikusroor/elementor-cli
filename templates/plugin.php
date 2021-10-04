<?php

/**
 * Plugin Name: PLUGIN_NAME
 * Description: PLUGIN_DESCRIPTION
 * Author:      PLUGIN_AUTHOR_NAME
 * Author URI:  PLUGIN_AUTHOR_URI
 */

namespace PLUGIN_NAME_NAMESPACE;


class PLUGIN_NAME_CLASS
{

    public function __construct()
    {
        add_action('elementor/widgets/widgets_registered', [$this, 'register_widgets']);
    }

    private function include_widgets()
    {
    }

    public function register_widgets()
    {

        $this->include_widgets();
    }
}

new PLUGIN_NAME_CLASS();
