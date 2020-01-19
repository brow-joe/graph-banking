# GraphBanking

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`graphiql`](http://localhost:4000/graphiql) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Query

#### Accounts
```
query {
  accounts {
      uuid
      currentBalance
      transactions {
        uuid
        address
        amount
        when
      }
  }
}
```

#### Account
```
query {
  account(uuid:"051d7bfa-d254-498b-ba81-5ef68846a96e") {
      uuid
      currentBalance
      transactions {
        uuid
        address
        amount
        when
      }
  }
}
```

## Mutation

#### Create account
```
mutation {
  openAccount(balance: 100) {
    uuid
    currentBalance
  }
}
```

#### Create transaction
```
mutation {
  transferMoney(sender: "051d7bfa-d254-498b-ba81-5ef68846a96e", address: "09df9525-46af-4bd3-a029-d82f91706dab", amount: 45.5) {
    uuid
    address
    amount
    when
  }
}
```


## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
