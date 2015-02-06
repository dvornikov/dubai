<?php
class Router {
    private static $routes = array();

    public static function route($pattern, $defaults = array()) {
        // Вытаскиваем данные о route.
        preg_match_all('#<([a-zA-Z0-9_]+)>#', $pattern, $params, PREG_SET_ORDER);

        // Меняем формальный pattern на реальный regex-pattern.
        // Необязательные параметры.
        if (strpos($pattern, '(') !== FALSE)
        {
            $pattern = str_replace(array('(', ')'), array('(?:', ')?'), $pattern);
        }
        $regex = preg_replace('#<([a-zA-Z0-9_]+)>#', '([a-zA-Z0-9_]+)', $pattern);
        $regex = '/^' . str_replace('/', '\/', $regex) . '$/';

        // Заполняем данные и позиции наших значений.
        foreach ($params as $i => $value) {
            self::$routes[$regex]['positions'][$value[1]] = $i;

            // defaults-значения
            self::$routes[$regex]['defaults'] = array();
            if (isset($defaults[$value[1]])) {
                self::$routes[$regex]['defaults'][$value[1]] = $defaults[$value[1]];
            }
        }
    }

    public static function execute($url) {
        // Сравниваем url с нашими routes и выполняем action.
        foreach (self::$routes as $pattern => $route) {
            if (preg_match($pattern, $url, $params)) {
                array_shift($params);

                $values = array();
                foreach ($route['positions'] as $n => $i) {
                    if (isset($params[$i]))
                        $values[$n] = $params[$i];
                }
                $values = array_replace_recursive($route['defaults'], $values);

                $controller = new $values['controller']();
                unset($values['controller']);

                $action = $values['action'];
                unset($values['action']);

                $_GET = array_replace_recursive($_GET, $values);

                return call_user_func_array(array($controller, $action), array());
            }
        }
    }
}

Router::route('<controller>(/<action>(/<id>))', array(
    'action' => 'format',
    'id' => 1
));
Router::route('users:edit/<id>');
Router::route('orders_stats.<action>.<id>');

// Например: 1.php?url=DateTime/gettimestamp
print Router::execute($_GET['url']);
?>
