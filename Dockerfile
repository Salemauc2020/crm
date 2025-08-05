FROM budibase/apps

# Railway يحتاج تحديد البورت
ENV PORT=10000
EXPOSE 10000

CMD ["./start-production.sh"]

