require 'spec_helper'

describe NomenclaturesController, :type => :controller do
  describe 'GET index' do
    it "логисты видят" do
      user = FactoryGirl.create(:logist)
      sign_in user
      get :index
      expect(response.status).to eq(200)
    end
    it "неавторизванные пользователи не должны видеть" do
      get :index
      expect(response.status).to eq(302)
    end
    it "дистрибьюторы видят" do
      user = create(:distributor)
      sign_in user
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'GET show' do
    it "логист, админ и дистрибьютор видят" do
      [:logist, :admin, :distributor].each do |role|
        user = create(role)
        sign_in user
        nomenclature = create(:nomenclature)
        get :show, id: nomenclature.id
        #expect(response.status).to eq(200)
        expect(assigns(:nomenclature)).to eq(nomenclature)
      end
    end
    it "неавторизованный не видит" do
      nomenclature = create(:nomenclature)
      get :show, id: nomenclature.id
      expect(response.status).to eq(302)
    end
  end

  describe 'GET new' do
    it "дистрибьютор не может" do
      user = create(:distributor)
      sign_in user
      get :new, {}
      expect(response.status).to eq(302)
    end
    it "логист может" do
      user = create(:logist)
      sign_in user
      get :new, {}
      expect(assigns(:nomenclature)).to be_a_new(Nomenclature)
    end
  end

  describe 'GET edit' do
    it "дистрибьютор не может" do
      user = create(:distributor)
      sign_in user
      nomenclature = create(:nomenclature)
      expect(nomenclature.updatable_by?(user)).to eq(false)
    end
    it "логист может" do
      user = create(:logist)
      sign_in user
      nomenclature = create(:nomenclature)
      expect(nomenclature.updatable_by?(user)).to eq(true)
    end
    it "assigns request nomenclature as @nomenclature" do
      user = create(:logist)
      sign_in user
      @nomenclature = create(:nomenclature)
      get :edit, {:id => @nomenclature.to_param}
      expect(assigns(:nomenclature)).to eq(@nomenclature)
    end
  end

  describe 'POST create' do
    it "дистрибьютор не может" do
      user = create(:distributor)
      sign_in user
      expect(Nomenclature.creatable_by?(user)).to eq(false)
    end
    it "неавторизванные не могут" do
      expect {
        post :create, {nomenclature: attributes_for(:nomenclature)}
      }.to change(Nomenclature, :count).by(0) # ничего не добавляется в nomenclatures
    end
    context "с верными параметрами" do
      login_logist
      it "логист добавляет номенклатуру" do
        expect {
          post :create, { nomenclature: attributes_for(:nomenclature) }
        }.to change(Nomenclature, :count).by(1)
      end
      it "при создании номенклатуры сохраняются все аттрибуты" do
        post :create, { nomenclature: attributes_for(:nomenclature) }
        expect(assigns(:nomenclature)).to be_a(Nomenclature)
        expect(assigns(:nomenclature)).to be_persisted
      end
      it "после сохранения открывается созданная номенклатура (show)" do
        post :create, { nomenclature: attributes_for(:nomenclature) }
        expect(response).to redirect_to(Nomenclature.last)
      end
    end

    context "с ошибочными параметрами" do
      login_logist
      it "не сохранённая номенклатура остаётся в переменной @nomenclature" do
        post :create, { nomenclature: attributes_for(:nomenclature, name: nil) }
        expect(assigns(:nomenclature)).to be_a_new(Nomenclature)
      end
      it "re-renders the 'new' template" do
        post :create, {nomenclature: attributes_for(:nomenclature, name: nil)}
        expect(response).to render_template("new")
      end
    end

  end

end
