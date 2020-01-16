defmodule GraphBanking.AccountController do
  use GraphBanking.Web, :controller

  alias GraphBanking.Account
  alias GraphBanking.Transaction

  plug :scrub_params, "transaction" when action in [:add_transaction]

  def index(conn, _params) do
    accounts = Repo.all(Account)
    render(conn, "index.html", accounts: accounts)
  end

  def new(conn, _params) do
    changeset = Account.changeset(%Account{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"account" => account_params}) do
    changeset = Account.changeset(%Account{}, account_params)

    case Repo.insert(changeset) do
      {:ok, _account} ->
        conn
        |> put_flash(:info, "Account created successfully.")
        |> redirect(to: account_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Repo.get!(Account, id) |> Repo.preload([:transactions])
    changeset = Transaction.changeset(%Transaction{})
    render(conn, "show.html", account: account, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account)
    render(conn, "edit.html", account: account, changeset: changeset)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Repo.get!(Account, id)
    changeset = Account.changeset(account, account_params)

    case Repo.update(changeset) do
      {:ok, account} ->
        conn
        |> put_flash(:info, "Account updated successfully.")
        |> redirect(to: account_path(conn, :show, account))
      {:error, changeset} ->
        render(conn, "edit.html", account: account, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Repo.get!(Account, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(account)

    conn
    |> put_flash(:info, "Account deleted successfully.")
    |> redirect(to: account_path(conn, :index))
  end

  def add_transaction(conn, %{"transaction" => transaction_params, "account_id" => account_id}) do
    params = Map.put(transaction_params, "when", DateTime.utc_now)
    changeset = Transaction.changeset(%Transaction{}, Map.put(params, "account_id", account_id))
    account = Account |> Repo.get(account_id) |> Repo.preload([:transactions])

    if changeset.valid? do
      Repo.insert(changeset)
      
      conn
      |> put_flash(:info, "Transaction added.")
      |> redirect(to: account_path(conn, :show, account))
    else
      render(conn, "show.html", account: account, changeset: changeset)
    end
  end

end
