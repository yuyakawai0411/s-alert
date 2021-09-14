FROM  nginx:stable

RUN rm -f /etc/nginx/conf.d/*

COPY nginx.conf /etc/nginx/conf.d/myapp.conf

# ヘルスチェック
HEALTHCHECK --interval=30s --timeout=5s --start-period=300s --retries=5 CMD curl -f http://localhost/ || exit 1

CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf