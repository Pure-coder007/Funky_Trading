# Funky_Trading

Static website for Funky Universal Trading Limited.

## Deploy To Your Ubuntu Droplet

This project is a plain static site. You do not need Node, PM2, or a backend process. The simplest production setup is:

1. Clone the site from GitHub into `/var/www/funky`
2. Serve them with Nginx
3. Point your domain to the Droplet IP `143.198.113.215`

### 1. Install Nginx on the server

SSH into the Droplet:

```bash
ssh root@143.198.113.215
```

Then run:

```bash
sudo apt update
sudo apt install -y nginx git
```

### 2. Clone the website from GitHub on the server

On the Droplet:

```bash
cd /var/www
sudo git clone https://github.com/Pure-coder007/Funky_Trading.git funky
sudo chown -R www-data:www-data /var/www/funky
```

### 3. Add the Nginx site config

From the server:

```bash
sudo cp /var/www/funky/deploy/nginx-funky.conf /etc/nginx/sites-available/funky
sudo ln -sf /etc/nginx/sites-available/funky /etc/nginx/sites-enabled/funky
sudo rm -f /etc/nginx/sites-enabled/default
sudo nginx -t
sudo systemctl reload nginx
```

The site will then load from:

```text
http://143.198.113.215/
```

### 4. Optional: connect a domain

If you have a domain, create an `A` record pointing to:

```text
143.198.113.215
```

Then replace:

```nginx
server_name _;
```

with:

```nginx
server_name yourdomain.com www.yourdomain.com;
```

Reload Nginx again:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

### 5. Optional: enable HTTPS with Let's Encrypt

After the domain is pointing correctly:

```bash
sudo apt install -y certbot python3-certbot-nginx
sudo certbot --nginx -d yourdomain.com -d www.yourdomain.com
```

### 6. Future updates from GitHub

Each time you push new changes to GitHub, update the server with:

```bash
cd /var/www/funky
sudo git pull --ff-only origin main
sudo systemctl reload nginx
```

Or use the helper script in this repo:

```bash
sudo bash /var/www/funky/scripts/server-refresh.sh /var/www/funky main
sudo systemctl reload nginx
```

## Files Added For Deployment

- `scripts/server-refresh.sh`: updates the server checkout from GitHub
- `deploy/nginx-funky.conf`: Nginx config for the Droplet
