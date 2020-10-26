<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'database' );

/** MySQL database username */
define( 'DB_USER', 'rzafari42' );

/** MySQL database password */
define( 'DB_PASSWORD', 'rzafari42' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '$__CK[5+piOK?2~+joxlavEa0,&B*bN$|fU+Tj{GWF|T!NSH7R.WJpPk&.[$T9*S');
define('SECURE_AUTH_KEY',  'h~mvj?jvJp@<s[a+cqMQAdnp_HiTFG+;l/p6>%B-6TacI6`;R`H9{ED7EAH~!Ez{');
define('LOGGED_IN_KEY',    '4@u1yUtgmd.-e7zc_W%  tGboO8|0v^;5QMTQDrBFPp%?|*S^U|x5BPQL2h}q]M*');
define('NONCE_KEY',        '>7w)a@!ZzkWkAW[:(I+B3b|@?d%/rs50g%0<O[L~8JZaLphe2rj66$QU3h8l>#| ');
define('AUTH_SALT',        '+-$}$-d*D|*,7d4<LO2QWFqiQ6,k~gg]2 A7 tS4;c$Lq#*{SDMi2qr;*rub&mDP');
define('SECURE_AUTH_SALT', '+|zq[+}Ys7HURr7MS%4dI)@@|`vsD<2b.JCW[#IN-+~Gv+%IYL+Lc0 }oN~}eo/C');
define('LOGGED_IN_SALT',   '-)8=9LInR89shu)@TmEonEt9]4vk+s,Q/+R}iZO&N(:E+H3|@J{+G-ziy!bd@H5%');
define('NONCE_SALT',       'hhG&eT>UlG8kz}~Bkr!eHh^vI(+m^IrBCs}Rk-%O0pPF^/{HGG0G+hhMnst4:2?|');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true);

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';