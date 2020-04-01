<?php declare(strict_types=1);

namespace Features;

use PDO;
use Psr\Container\ContainerInterface as PsrContainer;
use RuntimeException;

class DependencyLoader implements PsrContainer
{
    /** @var mixed[] */
    private array $items = [];

    /**
     * {@inheritdoc}
     */
    public function has($name)
    {
        return array_key_exists($name, $this->items);
    }

    /**
     * {@inheritdoc}
     */
    public function get($name)
    {
        if ($this->has($name) === false) {
            throw new RuntimeException("The item '$name' is not registered");
        }
        return $this->items[$name];
    }

    public static function bootstrap(): self
    {
        $loader = new self();

        $loader->items[PDO::class] = self::loadPdo();

        return $loader;
    }

    private static function loadPdo(): PDO
    {
        $dsn = getenv('DB_DSN'); // drive://user:pass@host:port/dbname

        [$driver, $dsnTail] = explode('://', $dsn);
        [$userAndPass, $dsnTail] = explode('@', $dsnTail);
        [$host, $port] = explode(':', $dsnTail);
        [$user, $pass] = explode(':', $userAndPass);

        return new PDO("$driver:host=$host;port=$port", $user, $pass);
    }
}
