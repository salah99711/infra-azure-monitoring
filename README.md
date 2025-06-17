# \# 📊 Projet de Supervision Azure avec Terraform et la Stack TIG

# 

# Ce projet met en place une infrastructure de supervision complète sur Microsoft Azure, déployée automatiquement avec \*\*Terraform\*\* et basée sur la stack \*\*TIG\*\* (\*\*Telegraf + InfluxDB + Grafana\*\*).

# 

# \## 🌟 Objectifs

# 

# \- Déployer automatiquement une infrastructure cloud sur Azure via Terraform.

# \- Mettre en place un système de supervision de ressources (CPU, RAM, disque, etc.).

# \- Visualiser les métriques en temps réel dans un tableau de bord Grafana.

# \- Permettre un monitoring simple et évolutif dans un environnement cloud.

# 

# ---

# 

# \## 📌 Description de l'Architecture

# 

# Le projet déploie deux machines virtuelles sur Azure dans un réseau privé :

# 

# \-   \*\*`vm-web`\*\* : Simule une application ou un service à surveiller.

# \-   \*\*`vm-monitoring`\*\* : Héberge la stack de supervision TIG (InfluxDB, Telegraf, Grafana).

# 

# Chaque machine virtuelle dispose d'une adresse IP publique pour permettre l'accès distant (SSH, interface web de Grafana). Un groupe de sécurité réseau (NSG) filtre les flux pour n'autoriser que les ports nécessaires.

# 

# !\[Diagramme de l'architecture du monitoring cloud](img/architecture-monitoring-cloud.png)

# 

# \### 🔧 Composants Déployés

# 

# | Composant | Description |

# | :--- | :--- |

# | \*\*Terraform\*\* | Outil d'Infrastructure-as-Code pour créer les ressources Azure (RG, VNet, NSG, VMs, IPs). |

# | \*\*Telegraf\*\* | Agent collecteur de métriques système (CPU, RAM, disque, réseau...). |

# | \*\*InfluxDB\*\* | Base de données optimisée pour les séries temporelles (Time Series) pour stocker les métriques. |

# | \*\*Grafana\*\* | Interface graphique pour visualiser les données avec des dashboards dynamiques et personnalisables. |

# 

# !\[Diagramme des rôles des composants de la stack TIG](img/roles-composants-stack.png)

# 

# ---

# 

# \## 🚀 Étapes de Déploiement

# 

# 1\.  \*\*Cloner le dépôt\*\* et se placer dans le bon répertoire :

# &nbsp;   ```bash

# &nbsp;   git clone \[https://github.com/salah99711/infra-azure-monitoring.git](https://github.com/salah99711/infra-azure-monitoring.git)

# &nbsp;   cd infra-azure-monitoring/terraform

# &nbsp;   ```

# 

# 2\.  \*\*Prérequis\*\* : Avant de lancer Terraform, assurez-vous d'avoir configuré votre clé SSH publique dans le fichier `vm.tf`. Cela est indispensable pour vous connecter aux machines virtuelles après leur création.

# 

# 3\.  \*\*Initialiser Terraform\*\* :

# &nbsp;   ```bash

# &nbsp;   terraform init

# &nbsp;   ```

# 

# 4\.  \*\*Vérifier le plan de déploiement\*\* (étape optionnelle mais recommandée) :

# &nbsp;   ```bash

# &nbsp;   terraform plan

# &nbsp;   ```

# 

# 5\.  \*\*Appliquer le déploiement\*\* pour créer les ressources sur Azure :

# &nbsp;   ```bash

# &nbsp;   terraform apply

# &nbsp;   ```

# &nbsp;   > Tapez `yes` lorsque la confirmation vous est demandée.

# 

# 6\.  \*\*Se connecter à la VM de monitoring\*\* en utilisant l'IP publique fournie en sortie par Terraform :

# &nbsp;   ```bash

# &nbsp;   ssh azureuser@<IP\_PUBLIC\_VM\_MONITORING>

# &nbsp;   ```

# 

# 7\.  \*\*Installer la stack TIG\*\* sur la `vm-monitoring`. Cela implique généralement :

# &nbsp;   - L'installation des paquets `influxdb`, `telegraf`, et `grafana`.

# &nbsp;   - La configuration du fichier `/etc/telegraf/telegraf.conf` pour envoyer les métriques à InfluxDB.

# 

# 8\.  \*\*Lancer les services\*\* et s'assurer qu'ils démarrent automatiquement avec le système :

# &nbsp;   ```bash

# &nbsp;   sudo systemctl enable --now influxdb

# &nbsp;   sudo systemctl enable --now telegraf

# &nbsp;   sudo systemctl enable --now grafana-server

# &nbsp;   ```

# 

# 9\.  \*\*Configurer Grafana\*\* via votre navigateur :

# &nbsp;   - \*\*Accès\*\* : `http://<IP\_PUBLIC\_VM\_MONITORING>:3000`

# &nbsp;   - \*\*Source de données\*\* : Ajoutez InfluxDB comme nouvelle source de données.

# &nbsp;   - \*\*Dashboards\*\* : Créez vos tableaux de bord pour visualiser l'utilisation du CPU, de la RAM, du Disque, etc.

# 

# ---

# 

# \### 📷 Exemples de Dashboards Grafana

# 

# Vous pouvez créer des panneaux pour superviser divers indicateurs clés :

# 

# \-   \*\*CPU\*\* : `usage\_system`, `usage\_user`, `usage\_idle`

# \-   \*\*RAM\*\* : `used\_percent`

# \-   \*\*Disque\*\* : `used\_percent` par partition (`/`, `/mnt`, etc.)

# \-   \*\*Système\*\* : Uptime, nombre de processus

# \-   \*\*Réseau\*\* : `bytes\_sent`, `bytes\_recv`

# 

# \### 🧠 Compétences Mobilisées

# 

# \-   \*\*Cloud\*\* : Azure (VM, VNet, NSG, IP Publique)

# \-   \*\*IaC (Infrastructure as Code)\*\* : Terraform (déploiement automatisé et reproductible)

# \-   \*\*Monitoring\*\* : Stack TIG (Telegraf, InfluxDB, Grafana)

# \-   \*\*Visualisation de données\*\* : Grafana

# \-   \*\*Système d'exploitation\*\* : Linux (configuration système, gestion des services `systemd`)

# \-   \*\*Versionning\*\* : Git \& GitHub

