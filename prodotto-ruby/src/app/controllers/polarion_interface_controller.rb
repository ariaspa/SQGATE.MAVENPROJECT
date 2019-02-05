class PolarionInterfaceController < ApplicationController

    require 'rest-client'
    require 'uri'

    def test
        render text: 'Hello'
    end

    def login
        begin
            Rails.logger.debug("Config #{Rails.application.config.frontend}")
            backendBaseUrl = Rails.application.config.frontend['backend.url']
            endpoint = Rails.application.config.frontend['login.endpoint']

            username = params[:username]
            password = params[:password]
            
            url = buildUrl('login')
            logger.debug("URL: #{url}")

            response = RestClient::Request.execute(method: :post, url: url, headers: headers, payload: {:username => username, :password => password}, timeout: 1200)

            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            

            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def search
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]
            searchQuery = params[:searchQuery]
            logger.debug("token: #{token}")
            logger.debug("searchQuery: #{searchQuery}")

            url = buildUrl('search')

            headers = {}
            headers[headerName] = token
            url = url + "?searchQuery=" + searchQuery
            logger.debug(url)

            response = RestClient::Request.execute(method: :get, url: url, headers: headers, timeout: 1200)
            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def deleteFavorite
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]

            repo = params[:repo]
            uri = params[:uri]
            logger.debug("Repo: #{repo}")
            logger.debug("URI: #{uri}")

            url = buildUrl('deleteFavorites')
            url = url + "/" + repo + "/" + URI.encode(uri)
            logger.debug(url)
            headers = {}
            headers[headerName] = token

            response = RestClient::Request.execute(method: :delete, url: url, headers: headers, timeout: 1200)
            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end

    end

    def getFavorites
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]

            headers = {}
            headers[headerName] = token

            url = buildUrl("getFavorites")

            logger.debug(url)

            response = RestClient::Request.execute(method: :get, url: url, headers: headers, timeout: 1200)

            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def logout
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]

            headers = {}
            headers[headerName] = token

            url = buildUrl("logout")

            logger.debug(url)

            response = RestClient::Request.execute(method: :post, url: url, payload: {}, headers: headers, timeout: 1200)
            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            llogger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def details
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]
            repo = params[:repo]
            uri = params[:uri]
            headers = {}
            headers[headerName] = token

            url = buildUrl("details")
            url = url + "/" + repo + "/" + URI.encode(uri)
            logger.debug(url)

            response = RestClient::Request.execute(method: :get, url: url, headers: headers, timeout: 1200)
            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def addFavorite
        begin
            headerName = Rails.application.config.frontend['token.header']
            token = request.headers[headerName]

            headers = {}
            headers[headerName] = token

            projectid = params[:projectid]
            repo = params[:repo]
            title = params[:title]
            uri = params[:uri]
            wid = params[:wid]
            codice = params[:codice]
            projectname = params[:projectname]
            url = buildUrl("addFavorites")
            payload = {:projectid=>projectid, :repo=>repo, :title=>title,:uri=>uri,:wid=>wid,:codice=>codice,:projectname=>projectname}

            response = RestClient::Request.execute(method: :post, url: url, payload: payload, headers: headers, timeout: 1200)
            logger.debug("code: #{response.code}")
            logger.debug("body: #{response.body}")
            
            render json: response.body
        rescue  RestClient::ExceptionWithResponse => e
            logger.debug(e.response.code)
            if e.response.code == 401
                render json: {error: 'Anauthorized'}, status: 401
            else
                render json: {error: 'Internal Server Error'}, status: 500
            end
            
        end
    end

    def buildUrl(endpoint)
        backendBaseUrl = Rails.application.config.frontend['backend.url']
        endpoint = Rails.application.config.frontend[endpoint+'.endpoint']

         url = backendBaseUrl + endpoint
         logger.debug("URL: #{url}")
         return url
    end

    
end
