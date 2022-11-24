<?php

class SessionManager
{

    public static function init()
    {
        $day30 = 86400 * 30;
        ini_set('session.gc_maxlifetime', $day30);
        ini_set('session.cookie_lifetime', $day30);

        session_start();
    }

    // --------------------------------------------------------------------------------
    //  for logic
    //  自行定義的 session name
    // --------------------------------------------------------------------------------

    public static function projectKey()
    {
        return SessionManager::get('projectKey');
    }

    public static function projectName()
    {
        return SessionManager::get('useObject');
    }

    public static function daoName()
    {
        return SessionManager::get('useDao');
    }

    public static function table()
    {
        return SessionManager::get('useTable');
    }

    public static function database()
    {
        return SessionManager::get('useDb');
    }

    // --------------------------------------------------------------------------------
    //  basic
    // --------------------------------------------------------------------------------

    public static function get($key, $defaultValue=null)
    {
        return $_SESSION[$key] ?? $defaultValue;
    }

    public static function set($key, $value)
    {
        return $_SESSION[$key] = $value;
    }

    public static function remove($key)
    {
        unset($_SESSION[$key]);
    }

    public static function reset()
    {
        self::set('useDb', null);
    }

    // --------------------------------------------------------------------------------
    //  private
    // --------------------------------------------------------------------------------

}

//