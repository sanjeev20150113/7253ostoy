FROM centos
# Disable default repositories (optional, but recommended for security)
RUN sed -i 's/enabled=1/enabled=0/g' /etc/yum.repos.d/CentOS-Linux-*

# Add CentOS vault repository (adjust URL if needed)
RUN yum -y install curl
RUN curl -sSL https://vault.centos.org/8.5.2111/centos/8/Packages/centos-repos-vault.repo | yum -y install -

# Update and install packages
RUN yum -y update
RUN yum -y install nginx

# Create and set permissions for Nginx cache directory
RUN mkdir -p /var/cache/nginx/client_temp && chown -R nginx:nginx /var/cache/nginx

# Add custom index.html
ADD index.html /usr/share/nginx/html/index.html

# Expose port and start Nginx
EXPOSE 80/tcp
CMD ["nginx", "-g", "daemon off;"]


