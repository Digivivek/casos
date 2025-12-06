<?php
// ---- keep headers clean (no warnings to output) ----
error_reporting(E_ALL & ~E_DEPRECATED & ~E_WARNING);
ini_set('display_errors', '0');   // hide notices/warnings
ob_start();                       // buffer any accidental output

// ---- loop guards ----
foreach (['p','rp'] as $q) {
    if (isset($_GET[$q]) && stripos((string)$_GET[$q], 'index.php') !== false) {
        unset($_GET[$q]);
    }
}

// ---- compute a stable path for the loader (never null) ----
$reqPath = parse_url($_SERVER['REQUEST_URI'] ?? '/', PHP_URL_PATH) ?? '/';
$param   = null;
if (isset($_GET['p']) && is_string($_GET['p']) && $_GET['p'] !== '')   $param = $_GET['p'];
if (isset($_GET['rp']) && is_string($_GET['rp']) && $_GET['rp'] !== '') $param = $_GET['rp'];

$path = $param !== null ? (string)$param : (string)$reqPath;
$path = '/' . ltrim($path, '/');
if ($path === '/index.php') { $path = '/'; }

// Present a clean path to the app
$_SERVER['REQUEST_URI'] = $path;
$_SERVER['PATH_INFO']   = $path;

// ---- reverse-proxy keys ----
$GLOBALS['_ta_rp_key'] = 'a55b83cff99869f511c919de320141e4';
$GLOBALS['_ta_reverse_proxy_id'] = '04c8dn';

// ---- boot & run ONCE ----
require __DIR__ . '/bootloader_218fc78d91335bef8bd0b3f91ce806e3.php';
$tarp = new TARPLoader([]);
$tarp->excute();

ob_end_flush();
