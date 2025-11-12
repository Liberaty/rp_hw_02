# Домашнее задание к занятию «Вычислительные мощности. Балансировщики нагрузки»  - Лепишин Алексей

### Подготовка к выполнению задания

1. Домашнее задание состоит из обязательной части, которую нужно выполнить на провайдере Yandex Cloud, и дополнительной части в AWS (выполняется по желанию). 
2. Все домашние задания в блоке 15 связаны друг с другом и в конце представляют пример законченной инфраструктуры.  
3. Все задания нужно выполнить с помощью Terraform. Результатом выполненного домашнего задания будет код в репозитории. 
4. Перед началом работы настройте доступ к облачным ресурсам из Terraform, используя материалы прошлых лекций и домашних заданий.

---
## Задание 1. Yandex Cloud 

**Что нужно сделать**

1. Создать бакет Object Storage и разместить в нём файл с картинкой:

 - Создать бакет в Object Storage с произвольным именем (например, _имя_студента_дата_).
 - Положить в бакет файл с картинкой.
 - Сделать файл доступным из интернета.
 
2. Создать группу ВМ в public подсети фиксированного размера с шаблоном LAMP и веб-страницей, содержащей ссылку на картинку из бакета:

 - Создать Instance Group с тремя ВМ и шаблоном LAMP. Для LAMP рекомендуется использовать `image_id = fd827b91d99psvq5fjit`.
 - Для создания стартовой веб-страницы рекомендуется использовать раздел `user_data` в [meta_data](https://cloud.yandex.ru/docs/compute/concepts/vm-metadata).
 - Разместить в стартовой веб-странице шаблонной ВМ ссылку на картинку из бакета.
 - Настроить проверку состояния ВМ.
 
3. Подключить группу к сетевому балансировщику:

 - Создать сетевой балансировщик.
 - Проверить работоспособность, удалив одну или несколько ВМ.
4. (дополнительно)* Создать Application Load Balancer с использованием Instance group и проверкой состояния.

Полезные документы:

- [Compute instance group](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/compute_instance_group).
- [Network Load Balancer](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/lb_network_load_balancer).
- [Группа ВМ с сетевым балансировщиком](https://cloud.yandex.ru/docs/compute/operations/instance-groups/create-with-balancer).

---

## Решение

1. Проверяем ```terraform plan```, что создадутся все необходимые ресурсы:

![1.1.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/1.1.png?raw=true)

В том числе s3 из [**bucket.tf**](https://github.com/Liberaty/rp_hw_02/blob/main/bucket.tf)

![1.2.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/1.2.png?raw=true)

После применения убеждаемся, что s3 создался и картинка в нем:

![1.3.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/1.3.png?raw=true)

И картинка доступна из интернета по адресу https://lepishin-12112025.storage.yandexcloud.net/image.jpg (скриншот сделан в telegram, где при указании ссылки она сразу же загружается):

![1.4.jpg](https://github.com/Liberaty/rp_hw_02/blob/main/img/1.4.jpg?raw=true)

2. Убеждаемся, что создалась группа из трех ВМ в public подсети:

![2.0.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.0.png?raw=true)

![2.1.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.1.png?raw=true)

![2.2.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.2.png?raw=true)

![2.3.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.3.png?raw=true)

   Проверяем, что страница доступна по публичному IP каждой из ВМ:

![2.4.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.4.png?raw=true)

![2.5.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.5.png?raw=true)

![2.6.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/2.6.png?raw=true)

3. Убеждаемся, что сетевой балансировщик из [**nlb.tf**](https://github.com/Liberaty/rp_hw_02/blob/main/nlb.tf) создался в облаке:

![3.1.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/3.1.png?raw=true)

![3.2.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/3.2.png?raw=true)

И проверим, что страница открывается по публичному IP балансировщика:

![3.3.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/3.3.png?raw=true)

При остановке одной из машин, все продолжает работать

![3.4.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/3.4.png?raw=true)

4. Убеждаемся, что Application Load Balancer из [**alb.tf**](https://github.com/Liberaty/rp_hw_02/blob/main/alb.tf) успешно создался

![4.1.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/4.1.png?raw=true)

И проверяем, что страница открывается по публичному IP alb:

![4.2.png](https://github.com/Liberaty/rp_hw_02/blob/main/img/4.2.png?raw=true)


Пример bootstrap-скрипта:

```
#!/bin/bash
apt install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>My cool web-server</h1></html>" > index.html
```
### Правила приёма работы

Домашняя работа оформляется в своём Git репозитории в файле README.md. Выполненное домашнее задание пришлите ссылкой на .md-файл в вашем репозитории.
Файл README.md должен содержать скриншоты вывода необходимых команд, а также скриншоты результатов.
Репозиторий должен содержать тексты манифестов или ссылки на них в файле README.md.